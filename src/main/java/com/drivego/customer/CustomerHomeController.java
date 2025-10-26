package com.drivego.customer;

import com.drivego.messaging.model.ContactMessage;
import com.drivego.messaging.service.ContactMessageService;
import com.drivego.entity.User;
import com.drivego.user.UserService;
import com.drivego.repository.UserRepository;
import com.drivego.vehicle.Vehicle;
import com.drivego.vehicle.VehicleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/customer")
public class CustomerHomeController {

    @Autowired
    private ContactMessageService contactMessageService;
    
    @Autowired
    private VehicleService vehicleService;
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;

    /**
     * Global model attribute to add user to all customer pages
     */
    @ModelAttribute
    public void addUserToModel(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        if (userDetails != null) {
            User user = userService.findUserByEmail(userDetails.getUsername());
            if (user != null) {
                model.addAttribute("user", user);
            }
        }
    }

    /**
     * Customer Index Page
     */
    @GetMapping("/home")
    public String showHomePage() {
        // User is already added by @ModelAttribute
        return "index";
    }

    /**
     * Contact Us Page
     */
    @GetMapping("/contact")
    public String showContactPage(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        // If user is logged in, fetch ALL their messages (by any email they used)
        if (userDetails != null) {
            String email = userDetails.getUsername();
            
            // Get user full name
            User user = userRepository.findByEmail(email);
            if (user != null) {
                String fullName = user.getName();
                model.addAttribute("userName", fullName != null ? fullName.trim() : "");
            }
            
            // Get all messages
            List<ContactMessage> allMessages = contactMessageService.getAllMessages();
            
            // Filter to show messages from this user's email
            List<ContactMessage> messages = allMessages.stream()
                .filter(m -> m.getEmail() != null && m.getEmail().equalsIgnoreCase(email))
                .sorted((m1, m2) -> m2.getCreatedAt().compareTo(m1.getCreatedAt())) // Newest first
                .collect(java.util.stream.Collectors.toList());
            
            model.addAttribute("messages", messages);
            model.addAttribute("userEmail", email);
            
            // Count messages by status
            long newCount = messages.stream()
                .filter(m -> "NEW".equals(m.getStatus()) || "READ".equals(m.getStatus()))
                .count();
            long repliedCount = messages.stream()
                .filter(m -> "REPLIED".equals(m.getStatus()))
                .count();
            
            model.addAttribute("newCount", newCount);
            model.addAttribute("repliedCount", repliedCount);
        }
        
        return "messaging/customer/contact";
    }

    /**
     * Submit Contact Form (Create or Update)
     */
    @PostMapping("/contact")
    public String submitContactForm(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestParam("name") String name,
            @RequestParam("subject") String subject,
            @RequestParam("message") String message,
            @RequestParam(value = "messageId", required = false) Long messageId,
            RedirectAttributes ra) {
        
        try {
            // Check if user is logged in
            if (userDetails == null) {
                ra.addFlashAttribute("error", "You must be logged in to send a message");
                return "redirect:/login";
            }
            
            String email = userDetails.getUsername(); // Use logged-in user's email
            
            if (name == null || name.trim().isEmpty()) {
                ra.addFlashAttribute("error", "Name is required");
                return "redirect:/customer/contact";
            }
            
            if (subject == null || subject.trim().isEmpty()) {
                ra.addFlashAttribute("error", "Subject is required");
                return "redirect:/customer/contact";
            }
            
            if (message == null || message.trim().isEmpty()) {
                ra.addFlashAttribute("error", "Message is required");
                return "redirect:/customer/contact";
            }
            
            // Check if this is an update
            if (messageId != null) {
                // Update existing message
                Optional<ContactMessage> existingOpt = contactMessageService.getMessageById(messageId);
                if (existingOpt.isPresent()) {
                    ContactMessage existing = existingOpt.get();
                    
                    // Verify the message belongs to this user
                    if (!existing.getEmail().equals(email)) {
                        ra.addFlashAttribute("error", "You can only edit your own messages");
                        return "redirect:/customer/contact";
                    }
                    
                    // Only allow editing if not yet replied
                    if ("REPLIED".equals(existing.getStatus())) {
                        ra.addFlashAttribute("error", "Cannot edit a message that has already been replied to");
                        return "redirect:/customer/contact";
                    }
                    
                    existing.setSubject(subject.trim());
                    existing.setMessage(message.trim());
                    ContactMessage updated = contactMessageService.saveMessage(existing);
                    
                    System.out.println("✏️ Contact message #" + updated.getId() + " updated by: " + email);
                    ra.addFlashAttribute("success", "Message updated successfully! (Message ID: #" + updated.getId() + ")");
                } else {
                    ra.addFlashAttribute("error", "Message not found");
                }
            } else {
                // Create new message
                System.out.println("📨 Processing contact form from: " + name + " (" + email + ")");
                
                ContactMessage contactMessage = new ContactMessage();
                contactMessage.setName(name.trim());
                contactMessage.setEmail(email); // Use logged-in user's email
                contactMessage.setSubject(subject.trim());
                contactMessage.setMessage(message.trim());
                
                ContactMessage saved = contactMessageService.saveMessage(contactMessage);
                
                System.out.println("✅ Contact message saved with ID: " + saved.getId() + " for email: " + email);
                ra.addFlashAttribute("success", "Thank you for contacting us! We'll get back to you soon. (Message ID: #" + saved.getId() + ")");
            }
            
        } catch (Exception e) {
            System.err.println("❌ Error saving contact message: " + e.getMessage());
            e.printStackTrace();
            ra.addFlashAttribute("error", "Failed to send message. Please try again later.");
        }
        
        return "redirect:/customer/contact";
    }
    
    /**
     * Delete Contact Message
     */
    @PostMapping("/contact/delete/{id}")
    public String deleteContactMessage(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable Long id,
            RedirectAttributes ra) {
        
        try {
            if (userDetails == null) {
                ra.addFlashAttribute("error", "You must be logged in");
                return "redirect:/login";
            }
            
            String email = userDetails.getUsername();
            Optional<ContactMessage> messageOpt = contactMessageService.getMessageById(id);
            
            if (messageOpt.isPresent()) {
                ContactMessage message = messageOpt.get();
                
                // Verify the message belongs to this user
                if (!message.getEmail().equals(email)) {
                    ra.addFlashAttribute("error", "You can only delete your own messages");
                    return "redirect:/customer/contact";
                }
                
                // Only allow deleting if not yet replied
                if ("REPLIED".equals(message.getStatus())) {
                    ra.addFlashAttribute("error", "Cannot delete a message that has already been replied to");
                    return "redirect:/customer/contact";
                }
                
                contactMessageService.deleteMessage(id);
                System.out.println("🗑️ Message #" + id + " deleted by: " + email);
                ra.addFlashAttribute("success", "Message deleted successfully!");
            } else {
                ra.addFlashAttribute("error", "Message not found");
            }
            
        } catch (Exception e) {
            System.err.println("❌ Error deleting message: " + e.getMessage());
            e.printStackTrace();
            ra.addFlashAttribute("error", "Failed to delete message");
        }
        
        return "redirect:/customer/contact";
    }

    /**
     * View Customer's Own Messages
     */
    @GetMapping("/my-messages")
    public String viewMyMessages(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        if (userDetails == null) {
            return "redirect:/login";
        }
        
        String email = userDetails.getUsername();
        System.out.println("📬 Customer viewing their messages: " + email);
        
        List<ContactMessage> messages = contactMessageService.getMessagesByEmail(email);
        model.addAttribute("messages", messages);
        model.addAttribute("totalMessages", messages.size());
        
        // Count messages by status
        long newCount = messages.stream().filter(m -> "NEW".equals(m.getStatus())).count();
        long repliedCount = messages.stream().filter(m -> "REPLIED".equals(m.getStatus())).count();
        
        model.addAttribute("newCount", newCount);
        model.addAttribute("repliedCount", repliedCount);
        
        return "customer_messages";
    }

    /**
     * Customer Profile Page
     */
    @GetMapping("/profile")
    public String showProfilePage() {
        // User is already added by @ModelAttribute
        return "customer_profile";
    }
    
    /**
     * Update Profile
     */
    @PostMapping("/profile/update")
    public String updateProfile(
            @RequestParam("firstName") String firstName,
            @RequestParam("lastName") String lastName,
            @RequestParam("email") String email,
            @RequestParam(value = "contactNum", required = false) String contactNum,
            @AuthenticationPrincipal UserDetails userDetails,
            RedirectAttributes redirectAttributes) {
        
        if (userDetails == null) {
            return "redirect:/login";
        }
        
        try {
            User user = userService.findUserByEmail(userDetails.getUsername());
            if (user == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "User not found");
                return "redirect:/customer/profile";
            }
            
            // Update user details
            user.setName(firstName + " " + lastName);
            user.setEmail(email);
            user.setContactNum(contactNum);
            
            userRepository.save(user);
            
            redirectAttributes.addFlashAttribute("successMessage", "Profile updated successfully!");
            return "redirect:/customer/profile";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to update profile: " + e.getMessage());
            return "redirect:/customer/profile";
        }
    }
    
    /**
     * Change Password
     */
    @PostMapping("/profile/change-password")
    public String changePassword(
            @RequestParam("currentPassword") String currentPassword,
            @RequestParam("newPassword") String newPassword,
            @RequestParam("confirmPassword") String confirmPassword,
            @AuthenticationPrincipal UserDetails userDetails,
            RedirectAttributes redirectAttributes) {
        
        if (userDetails == null) {
            return "redirect:/login";
        }
        
        try {
            User user = userService.findUserByEmail(userDetails.getUsername());
            if (user == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "User not found");
                return "redirect:/customer/profile";
            }
            
            // Verify current password
            if (!passwordEncoder.matches(currentPassword, user.getPassword())) {
                redirectAttributes.addFlashAttribute("errorMessage", "Current password is incorrect");
                return "redirect:/customer/profile";
            }
            
            // Validate new password
            if (newPassword == null || newPassword.length() < 8) {
                redirectAttributes.addFlashAttribute("errorMessage", "New password must be at least 8 characters long");
                return "redirect:/customer/profile";
            }
            
            // Check if passwords match
            if (!newPassword.equals(confirmPassword)) {
                redirectAttributes.addFlashAttribute("errorMessage", "New passwords do not match");
                return "redirect:/customer/profile";
            }
            
            // Update password
            user.setPassword(passwordEncoder.encode(newPassword));
            userRepository.save(user);
            
            redirectAttributes.addFlashAttribute("successMessage", "Password changed successfully!");
            return "redirect:/customer/profile";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to change password: " + e.getMessage());
            return "redirect:/customer/profile";
        }
    }

    /**
     * Browse Vehicles Page
     */
    @GetMapping("/vehicles")
    public String browseVehicles(
            @RequestParam(required = false) String search,
            @RequestParam(required = false) String fuelType,
            @RequestParam(required = false) String availability,
            @RequestParam(required = false, defaultValue = "model") String sortBy,
            Model model,
            @AuthenticationPrincipal UserDetails currentUser) {
        
        // User is already added by @ModelAttribute
        // Just set additional display attributes
        if (currentUser != null) {
            User user = userService.findUserByEmail(currentUser.getUsername());
            if (user != null) {
                model.addAttribute("userName", user.getName());
            } else {
                model.addAttribute("userName", currentUser.getUsername());
            }
            model.addAttribute("isLoggedIn", true);
        } else {
            model.addAttribute("userName", "Guest");
            model.addAttribute("isLoggedIn", false);
        }

        // Get all vehicles
        List<Vehicle> vehicles = vehicleService.getAllVehicles();

        // Apply search filter
        if (search != null && !search.trim().isEmpty()) {
            String searchLower = search.toLowerCase();
            vehicles = vehicles.stream()
                    .filter(v -> v.getModel().toLowerCase().contains(searchLower) 
                            || v.getFuelType().toLowerCase().contains(searchLower)
                            || v.getRegNo().toLowerCase().contains(searchLower))
                    .collect(Collectors.toList());
        }

        // Apply fuel type filter
        if (fuelType != null && !fuelType.isEmpty() && !fuelType.equals("ALL")) {
            vehicles = vehicles.stream()
                    .filter(v -> v.getFuelType().equalsIgnoreCase(fuelType))
                    .collect(Collectors.toList());
        }

        // Apply availability filter
        if (availability != null && !availability.isEmpty() && !availability.equals("ALL")) {
            boolean isAvailable = availability.equals("AVAILABLE");
            vehicles = vehicles.stream()
                    .filter(v -> v.getAvailability() == isAvailable)
                    .collect(Collectors.toList());
        }

        // Apply sorting
        if ("price".equals(sortBy)) {
            vehicles = vehicles.stream()
                    .sorted((v1, v2) -> Double.compare(v1.getRentalPrice(), v2.getRentalPrice()))
                    .collect(Collectors.toList());
        } else {
            vehicles = vehicles.stream()
                    .sorted((v1, v2) -> v1.getModel().compareToIgnoreCase(v2.getModel()))
                    .collect(Collectors.toList());
        }

        model.addAttribute("vehicles", vehicles);
        model.addAttribute("search", search);
        model.addAttribute("fuelType", fuelType);
        model.addAttribute("availability", availability);
        model.addAttribute("sortBy", sortBy);

        return "customer_vehicles";
    }

    // Simple user data class for passing to view
    public static class SimpleUser {
        private String name;
        private String email;

        public SimpleUser(String name, String email) {
            this.name = name;
            this.email = email;
        }

        public String getName() {
            return name;
        }

        public String getEmail() {
            return email;
        }
    }
}
