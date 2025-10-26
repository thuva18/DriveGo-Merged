package com.drivego.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "users")
public class User {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private Integer userId;

    @Column(name = "ru_id", length = 30)
    private String ruId;

    @Column(name = "first_name", length = 50)
    private String firstName;

    @Column(name = "last_name", length = 50)
    private String lastName;

    @Column(nullable = false, unique = true, length = 100)
    private String email;

    @Column(name = "contact_num", length = 20)
    private String contactNum;

    @Column(name = "is_guest")
    private Boolean isGuest = false;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_at")
    private Date createdAt;

    @Column(nullable = false, length = 255)
    private String password;

    @ManyToMany(fetch = FetchType.EAGER, cascade = {CascadeType.MERGE, CascadeType.REFRESH})
    @JoinTable(
            name = "users_roles",
            joinColumns = {@JoinColumn(name = "user_id", referencedColumnName = "user_id")},
            inverseJoinColumns = {@JoinColumn(name = "role_id", referencedColumnName = "id")})
    private List<Role> roles = new ArrayList<>();
    
    // Helper methods for backward compatibility
    public Integer getId() {
        return userId;
    }
    
    public void setId(Integer id) {
        this.userId = id;
    }
    
    public String getName() {
        if (firstName == null && lastName == null) return null;
        return (firstName != null ? firstName : "") + " " + (lastName != null ? lastName : "");
    }
    
    public void setName(String name) {
        if (name == null || name.trim().isEmpty()) {
            this.firstName = null;
            this.lastName = null;
            return;
        }
        String[] parts = name.trim().split(" ", 2);
        this.firstName = parts.length > 0 ? parts[0] : null;
        this.lastName = parts.length > 1 ? parts[1] : null;
    }
    
    // Additional getters and setters that may be missing due to Lombok issues
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getContactNum() {
        return contactNum;
    }
    
    public void setContactNum(String contactNum) {
        this.contactNum = contactNum;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public List<Role> getRoles() {
        return roles;
    }
    
    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }
    
    @PrePersist
    protected void onCreate() {
        if (createdAt == null) {
            createdAt = new Date();
        }
        if (isGuest == null) {
            isGuest = false;
        }
    }
}