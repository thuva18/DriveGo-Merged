package com.drivego.user;

import com.drivego.dto.UserDto;
import com.drivego.entity.Role;
import com.drivego.entity.User;
import com.drivego.repository.RoleRepository;
import com.drivego.repository.UserRepository;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin/users")
public class UserManagementController {
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private RoleRepository roleRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    // List all users
    @GetMapping
    public String listUsers(Model model,
                          @RequestParam(value = "success", required = false) String success,
                          @RequestParam(value = "error", required = false) String error,
                          @RequestParam(value = "created", required = false) String created) {
        List<UserDto> users = userService.findAllUsers();
        model.addAttribute("users", users);
        
        if (success != null) {
            model.addAttribute("success", success);
        }
        if (error != null) {
            model.addAttribute("error", error);
        }
        if (created != null) {
            model.addAttribute("created", created);
        }
        
        return "user/list";
    }
    
    // View user details
    @GetMapping("/{id}")
    public String viewUser(@PathVariable("id") Integer id, Model model, RedirectAttributes redirectAttributes) {
        try {
            User user = userService.findUserById(id);
            if (user == null) {
                redirectAttributes.addFlashAttribute("error", "User not found");
                return "redirect:/admin/users";
            }
            model.addAttribute("user", user);
            return "user/view";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error loading user: " + e.getMessage());
            return "redirect:/admin/users";
        }
    }
    
    // Show edit user form
    @GetMapping("/{id}/edit")
    public String editUserForm(@PathVariable("id") Integer id, Model model, RedirectAttributes redirectAttributes) {
        try {
            User user = userService.findUserById(id);
            if (user == null) {
                redirectAttributes.addFlashAttribute("error", "User not found");
                return "redirect:/admin/users";
            }
            
            // Convert to DTO
            UserDto userDto = new UserDto();
            userDto.setId(user.getId());
            String[] nameParts = user.getName() != null ? user.getName().split(" ", 2) : new String[]{"", ""};
            userDto.setFirstName(nameParts.length > 0 ? nameParts[0] : "");
            userDto.setLastName(nameParts.length > 1 ? nameParts[1] : "");
            userDto.setEmail(user.getEmail());
            userDto.setMobile(user.getContactNum());
            
            model.addAttribute("user", userDto);
            model.addAttribute("allRoles", roleRepository.findAll());
            model.addAttribute("userRoles", user.getRoles());
            return "user/edit";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error loading user: " + e.getMessage());
            return "redirect:/admin/users";
        }
    }
    
    // Update user
    @PostMapping("/{id}/update")
    @Transactional
    public String updateUser(@PathVariable("id") Integer id,
                            @RequestParam("firstName") String firstName,
                            @RequestParam("lastName") String lastName,
                            @RequestParam("email") String email,
                            @RequestParam(value = "mobile", required = false) String mobile,
                            @RequestParam(value = "password", required = false) String password,
                            @RequestParam(value = "role", required = false) String roleName,
                            RedirectAttributes redirectAttributes) {
        
        try {
            // Get the user first
            User user = userService.findUserById(id);
            if (user == null) {
                redirectAttributes.addFlashAttribute("error", "User not found");
                return "redirect:/admin/users";
            }
            
            // Validate required fields
            if (firstName == null || firstName.trim().isEmpty() || 
                lastName == null || lastName.trim().isEmpty() || 
                email == null || email.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "First name, last name, and email are required");
                return "redirect:/admin/users/" + id + "/edit";
            }
            
            // Update basic details
            user.setName(firstName.trim() + " " + lastName.trim());
            user.setEmail(email.trim());
            user.setContactNum(mobile != null ? mobile.trim() : "");
            
            // Update password if provided
            if (password != null && !password.trim().isEmpty()) {
                user.setPassword(passwordEncoder.encode(password));
            }
            
            // Update role if provided
            if (roleName != null && !roleName.isEmpty()) {
                user.getRoles().clear();
                Role role = roleRepository.findByName(roleName);
                if (role != null) {
                    user.getRoles().add(role);
                }
            }
            
            // Save all changes
            userRepository.save(user);
            userRepository.flush();
            
            redirectAttributes.addFlashAttribute("success", "User updated successfully");
            return "redirect:/admin/users/" + id;
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error updating user: " + e.getMessage());
            return "redirect:/admin/users/" + id + "/edit";
        }
    }
    
    // Change user role (AJAX endpoint)
    @PostMapping("/{id}/change-role")
    @ResponseBody
    public String changeUserRole(@PathVariable("id") Integer id,
                                @RequestParam("role") String roleName) {
        try {
            User user = userService.findUserById(id);
            if (user == null) {
                return "{\"success\": false, \"message\": \"User not found\"}";
            }
            
            Role role = roleRepository.findByName(roleName);
            if (role == null) {
                return "{\"success\": false, \"message\": \"Role not found\"}";
            }
            
            // Clear existing roles and add new role
            user.getRoles().clear();
            user.getRoles().add(role);
            
            // Save the user with updated roles
            userRepository.save(user);
            userRepository.flush();
            
            return "{\"success\": true, \"message\": \"Role updated successfully\"}";
        } catch (Exception e) {
            return "{\"success\": false, \"message\": \"" + e.getMessage() + "\"}";
        }
    }
    
    // Delete user
    @PostMapping("/{id}/delete")
    public String deleteUser(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        try {
            userService.deleteUserById(id);
            redirectAttributes.addFlashAttribute("success", "User deleted successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error deleting user: " + e.getMessage());
        }
        return "redirect:/admin/users";
    }
    
    // Show add user form
    @GetMapping("/new")
    public String showAddUserForm(Model model) {
        UserDto userDto = new UserDto();
        model.addAttribute("user", userDto);
        model.addAttribute("allRoles", roleRepository.findAll());
        return "user/form";
    }
    
    // Create new user
    @PostMapping("/create")
    @Transactional
    public String createUser(@Valid @ModelAttribute("user") UserDto userDto,
                            BindingResult result,
                            @RequestParam(value = "role", required = false) String roleName,
                            Model model,
                            RedirectAttributes redirectAttributes) {
        
        // Check for existing email
        User existingUser = userService.findUserByEmail(userDto.getEmail());
        if (existingUser != null) {
            result.rejectValue("email", "", "Email is already registered");
        }
        
        if (result.hasErrors()) {
            model.addAttribute("allRoles", roleRepository.findAll());
            return "user/form";
        }
        
        try {
            userService.saveUser(userDto);
            
            // Assign role if provided and different from default
            if (roleName != null && !roleName.isEmpty() && !roleName.equals("ROLE_USER")) {
                User newUser = userService.findUserByEmail(userDto.getEmail());
                if (newUser != null) {
                    newUser.getRoles().clear();
                    Role role = roleRepository.findByName(roleName);
                    if (role != null) {
                        newUser.getRoles().add(role);
                        userRepository.save(newUser);
                        userRepository.flush();
                    }
                }
            }
            
            // Use both flash attribute and query parameters for reliable message display
            redirectAttributes.addFlashAttribute("success", "User created successfully! Welcome to the team.");
            return "redirect:/admin/users?success=User created successfully&created=true";
        } catch (Exception e) {
            e.printStackTrace(); // Add logging to help debug
            model.addAttribute("allRoles", roleRepository.findAll());
            model.addAttribute("error", "Error creating user: " + e.getMessage());
            return "user/form";
        }
    }
}
