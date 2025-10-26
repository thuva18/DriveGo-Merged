package com.drivego.config;

import com.drivego.entity.Role;
import com.drivego.entity.User;
import com.drivego.repository.RoleRepository;
import com.drivego.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.List;

// @Component - DISABLED to use only real database data
public class AdminConfig implements CommandLineRunner {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Value("${admin.email:admin@drivego.com}")
    private String adminEmail;

    @Value("${admin.password:admin123}")
    private String adminPassword;

    @Value("${admin.name:DriveGo Admin}")
    private String adminName;

    @Value("${sample.user.email:user@drivego.com}")
    private String sampleUserEmail;

    @Value("${sample.user.password:user123}")
    private String sampleUserPassword;

    @Value("${sample.user.name:John Doe}")
    private String sampleUserName;

    @Override
    @Transactional
    public void run(String... args) throws Exception {
        // Create roles if they don't exist
        createRolesIfNotExist();
        
        // Create admin user if it doesn't exist
        createAdminUserIfNotExist();
        
        // Create sample regular user if it doesn't exist
        createSampleUserIfNotExist();
    }

    private void createRolesIfNotExist() {
        List<String> roleNames = Arrays.asList("ROLE_ADMIN", "ROLE_USER");
        
        for (String roleName : roleNames) {
            if (roleRepository.findByName(roleName) == null) {
                Role role = new Role();
                role.setName(roleName);
                roleRepository.save(role);
                System.out.println("Created role: " + roleName);
            }
        }
    }

    private void createAdminUserIfNotExist() {
        User existingAdmin = userRepository.findByEmail(adminEmail);
        
        if (existingAdmin == null) {
            // Create admin user
            User admin = new User();
            admin.setName(adminName);
            admin.setEmail(adminEmail);
            admin.setPassword(passwordEncoder.encode(adminPassword));
            
            // Save user first to get an ID
            admin = userRepository.save(admin);
            
            // Now assign admin role - get fresh reference from database
            Role adminRole = roleRepository.findByName("ROLE_ADMIN");
            if (adminRole != null) {
                // Add role to existing user
                admin.getRoles().add(adminRole);
                userRepository.save(admin);
            }
            
            System.out.println("Auto-generated admin user: " + adminEmail + " with password: " + adminPassword);
        } else {
            System.out.println("Admin user already exists: " + adminEmail);
        }
    }

    private void createSampleUserIfNotExist() {
        User existingUser = userRepository.findByEmail(sampleUserEmail);
        
        if (existingUser == null) {
            // Create sample regular user
            User user = new User();
            user.setName(sampleUserName);
            user.setEmail(sampleUserEmail);
            user.setPassword(passwordEncoder.encode(sampleUserPassword));
            
            // Save user first to get an ID
            user = userRepository.save(user);
            
            // Now assign user role - get fresh reference from database
            Role userRole = roleRepository.findByName("ROLE_USER");
            if (userRole != null) {
                // Add role to existing user
                user.getRoles().add(userRole);
                userRepository.save(user);
            }
            
            System.out.println("Auto-generated sample user: " + sampleUserEmail + " with password: " + sampleUserPassword);
        } else {
            System.out.println("Sample user already exists: " + sampleUserEmail);
        }
    }


}
