package com.drivego.user;

import com.drivego.dto.UserDto;
import com.drivego.entity.Role;
import com.drivego.entity.User;
import com.drivego.repository.RoleRepository;
import com.drivego.repository.UserRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final PasswordEncoder passwordEncoder;

    public UserServiceImpl(UserRepository userRepository, RoleRepository roleRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    @Transactional
    public void saveUser(UserDto userDto) {
        try {
            // Create user entity
            User user = new User();
            user.setName(joinName(userDto.getFirstName(), userDto.getLastName()));
            user.setEmail(userDto.getEmail());
            user.setContactNum(userDto.getMobile());
            user.setPassword(passwordEncoder.encode(userDto.getPassword()));

            // Find or create default role safely
            Role role = roleRepository.findByName("ROLE_USER");
            if (role == null) {
                // Check again in case of concurrent creation
                synchronized (this) {
                    role = roleRepository.findByName("ROLE_USER");
                    if (role == null) {
                        role = new Role();
                        role.setName("ROLE_USER");
                        role = roleRepository.save(role);
                    }
                }
            }
            
            // Save user first
            user = userRepository.save(user);
            
            // Clear any existing roles and set the default role
            user.getRoles().clear();
            user.getRoles().add(role);
            
            // Save the user with roles
            userRepository.save(user);
            
        } catch (Exception e) {
            System.err.println("Error saving user: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to create user: " + e.getMessage(), e);
        }
    }


    private String joinName(String first, String last) {
        if (first == null) first = "";
        if (last == null) last = "";
        return (first + " " + last).trim();
    }

    private Role checkRoleExist() {
        Role role = new Role();
        role.setName("ROLE_ADMIN");
        return roleRepository.save(role);
    }

    @Override
    public User findUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    @Override
    public List<UserDto> findAllUsers() {
        List<User> users = userRepository.findAll();
        return users.stream().map(this::convertEntityToDto).collect(Collectors.toList());
    }

    private UserDto convertEntityToDto(User user) {
        UserDto userDto = new UserDto();
        String fullName = user.getName() == null ? "" : user.getName();
        String[] parts = fullName.trim().split(" ", 2);
        userDto.setFirstName(parts.length > 0 ? parts[0] : "");
        userDto.setLastName(parts.length > 1 ? parts[1] : "");
        userDto.setEmail(user.getEmail());
        userDto.setMobile(user.getContactNum());
        userDto.setId(user.getId());
        
        // Add role information
        if (user.getRoles() != null && !user.getRoles().isEmpty()) {
            userDto.setRoles(user.getRoles().stream()
                .map(role -> role.getName())
                .collect(Collectors.toSet()));
        }
        
        return userDto;
    }

    @Override
    public User findUserById(Integer id) {
        return userRepository.findById(id).orElse(null);
    }

    @Override
    @Transactional
    public void updateUser(Integer id, UserDto userDto) {
        User user = userRepository.findById(id).orElse(null);
        if (user == null) {
            throw new IllegalArgumentException("User not found");
        }

        user.setName(joinName(userDto.getFirstName(), userDto.getLastName()));
        user.setEmail(userDto.getEmail());
        user.setContactNum(userDto.getMobile());

        if (userDto.getPassword() != null && !userDto.getPassword().isBlank()) {
            user.setPassword(passwordEncoder.encode(userDto.getPassword()));
        }

        userRepository.save(user);
    }

    @Override
    @Transactional
    public void deleteUserById(Integer id) {
        if (id == null) {
            throw new IllegalArgumentException("User id must not be null");
        }
        if (!userRepository.existsById(id)) {
            throw new IllegalArgumentException("User not found");
        }
        userRepository.deleteById(id);
    }
    
    @Override
    @Transactional
    public void updateUserRoles(Integer userId, List<String> roleNames) {
        User user = userRepository.findById(userId).orElse(null);
        if (user == null) {
            throw new IllegalArgumentException("User not found");
        }
        
        // Clear existing roles
        user.getRoles().clear();
        
        // Add new roles
        if (roleNames != null && !roleNames.isEmpty()) {
            for (String roleName : roleNames) {
                Role role = roleRepository.findByName(roleName);
                if (role != null) {
                    user.getRoles().add(role);
                }
            }
        }
        
        userRepository.save(user);
    }
    
    @Override
    public List<Role> getAllRoles() {
        return roleRepository.findAll();
    }
}
