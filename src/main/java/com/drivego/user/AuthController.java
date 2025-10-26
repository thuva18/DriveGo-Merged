package com.drivego.user;

import jakarta.validation.Valid;
import com.drivego.dto.UserDto;
import com.drivego.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.List;

@Controller
public class AuthController {
    private UserService userService;

    @Autowired
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    /**
     * Global model attribute to add user to all pages
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

    // handler method to handle home page request  
    @GetMapping({"/", "/index"})
    public String home() {
        return "index";
    }

    // handler method to handle user registration form request
    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        // create model object to store form data
        UserDto userDto = new UserDto();
        model.addAttribute("userDto", userDto);
        return "register";
    }

    // handler method to handle user registration form submit request
    @PostMapping("/register")
    public String registration(@Valid @ModelAttribute("userDto") UserDto userDto,
                               BindingResult result,
                               Model model,
                               RedirectAttributes redirectAttributes) {
        User existingUser = userService.findUserByEmail(userDto.getEmail());

        if (existingUser != null && existingUser.getEmail() != null && !existingUser.getEmail().isEmpty()) {
            result.rejectValue("email", "", "There is already an account registered with the same email");
        }

        if (result.hasErrors()) {
            model.addAttribute("userDto", userDto);
            model.addAttribute("validationErrors", "Please fix the errors below and try again.");
            return "register";
        }

        try {
            userService.saveUser(userDto);
            redirectAttributes.addFlashAttribute("success", "Account created successfully! You can now sign in.");
            return "redirect:/login?success";
        } catch (Exception e) {
            model.addAttribute("userDto", userDto);
            model.addAttribute("error", "An error occurred while creating your account. Please try again.");
            return "register";
        }
    }

    // handler method to handle list of users
    @GetMapping("/users")
    public String users(Model model) {
        List<UserDto> users = userService.findAllUsers();
        model.addAttribute("users", users);
        return "users";
    }

    // handler method to handle login request
    @GetMapping("/login")
    public String login() {
        return "login";
    }

    // Post-login redirect based on role
    @GetMapping("/login-success")
    public String loginSuccess(@AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails == null) {
            return "redirect:/login";
        }
        
        // Check if user has ADMIN role
        boolean isAdmin = userDetails.getAuthorities().stream()
            .anyMatch(authority -> authority.getAuthority().equals("ROLE_ADMIN"));
        
        if (isAdmin) {
            return "redirect:/dashboard"; // Admin dashboard
        } else {
            return "redirect:/customer/home"; // Customer home page
        }
    }

    // View own profile
    @GetMapping("/profile")
    public String profile(Model model, @AuthenticationPrincipal UserDetails currentUser) {
        if (currentUser == null) {
            return "redirect:/login";
        }
        User user = userService.findUserByEmail(currentUser.getUsername());
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("user", userService.findUserByEmail(user.getEmail())); // entity
        // also include dto for forms if needed
        model.addAttribute("userDto", convertToDto(user));
        return "profile";
    }

    // Show edit form
    @GetMapping("/profile/edit")
    public String editProfile(Model model, @AuthenticationPrincipal UserDetails currentUser) {
        if (currentUser == null) return "redirect:/login";
        User user = userService.findUserByEmail(currentUser.getUsername());
        if (user == null) return "redirect:/login";

        UserDto dto = convertToDto(user);
        model.addAttribute("userDto", dto);
        return "edit_profile";
    }

    // Save profile update
    @PostMapping("/profile/update")
    public String updateProfile(@Valid @ModelAttribute("userDto") UserDto userDto,
                                BindingResult result,
                                @AuthenticationPrincipal UserDetails currentUser,
                                RedirectAttributes redirectAttributes,
                                Model model) {
        if (currentUser == null) return "redirect:/login";
        User current = userService.findUserByEmail(currentUser.getUsername());
        if (current == null) return "redirect:/login";

        // If user changed email to one that exists and not his own, error
        User existing = userService.findUserByEmail(userDto.getEmail());
        if (existing != null && !existing.getId().equals(current.getId())) {
            result.rejectValue("email", "", "Email already in use");
        }

        if (result.hasErrors()) {
            model.addAttribute("userDto", userDto);
            return "edit_profile";
        }

        userService.updateUser(current.getId(), userDto);
        redirectAttributes.addFlashAttribute("success", "Profile updated successfully");
        return "redirect:/profile";
    }

    @PostMapping("/profile/delete")
    public String deleteAccount(@AuthenticationPrincipal UserDetails currentUser,
                                RedirectAttributes redirectAttributes) {
        if (currentUser == null) {
            return "redirect:/login";
        }
        User user = userService.findUserByEmail(currentUser.getUsername());
        if (user == null) {
            return "redirect:/login";
        }
        try {
            userService.deleteUserById(user.getId());
            SecurityContextHolder.clearContext();
            redirectAttributes.addFlashAttribute("accountDeleted", "Your DriveGo account has been deleted.");
        } catch (IllegalArgumentException ex) {
            redirectAttributes.addFlashAttribute("accountDeleteError", ex.getMessage());
            return "redirect:/profile";
        }
        return "redirect:/index";
    }

    // helper convert
    private UserDto convertToDto(User user) {
        UserDto dto = new UserDto();
        dto.setId(user.getId());
        String[] parts = user.getName() == null ? new String[]{""} : user.getName().trim().split(" ", 2);
        dto.setFirstName(parts.length > 0 ? parts[0] : "");
        dto.setLastName(parts.length > 1 ? parts[1] : "");
        dto.setEmail(user.getEmail());
        dto.setMobile(user.getContactNum());
        // password left null for security
        return dto;
    }

    // --- Admin user management endpoints ---
    @GetMapping("/users/add")
    public String showAddUserForm(Model model) {
        UserDto user = new UserDto();
        model.addAttribute("user", user);
        return "users_add";
    }

    @PostMapping("/users/save")
    public String saveUserByAdmin(@Valid @ModelAttribute("user") UserDto userDto,
                                  BindingResult result,
                                  Model model,
                                  RedirectAttributes redirectAttributes) {
        // Basic duplicate email check
        User existingUser = userService.findUserByEmail(userDto.getEmail());
        if (existingUser != null && existingUser.getEmail() != null && !existingUser.getEmail().isEmpty()) {
            result.rejectValue("email", "", "There is already an account registered with the same email");
        }

        if (result.hasErrors()) {
            model.addAttribute("user", userDto);
            return "users_add";
        }

        userService.saveUser(userDto);
        redirectAttributes.addFlashAttribute("success", "User created successfully");
        return "redirect:/users";
    }

    @GetMapping("/users/{id}")
    public String viewUser(@PathVariable("id") Integer id, Model model) {
        User user = userService.findUserById(id);
        if (user == null) {
            return "redirect:/users";
        }
        model.addAttribute("user", user);
        model.addAttribute("userDto", convertToDto(user));
        return "users_view";
    }

    @GetMapping("/users/{id}/edit")
    public String editUser(@PathVariable("id") Integer id, Model model) {
        User user = userService.findUserById(id);
        if (user == null) {
            return "redirect:/users";
        }
        UserDto dto = convertToDto(user);
        model.addAttribute("userDto", dto);
        return "users_edit";
    }

    @PostMapping("/users/{id}/update")
    public String updateUserByAdmin(@PathVariable("id") Integer id,
                                    @Valid @ModelAttribute("userDto") UserDto userDto,
                                    BindingResult result,
                                    Model model,
                                    RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("userDto", userDto);
            return "users_edit";
        }

        userService.updateUser(id, userDto);
        redirectAttributes.addFlashAttribute("success", "User updated successfully");
        return "redirect:/users";
    }

    @PostMapping("/users/{id}/delete")
    public String deleteUserByAdmin(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        try {
            userService.deleteUserById(id);
            redirectAttributes.addFlashAttribute("success", "User deleted successfully");
        } catch (IllegalArgumentException ex) {
            redirectAttributes.addFlashAttribute("error", ex.getMessage());
        }
        return "redirect:/users";
    }
}
