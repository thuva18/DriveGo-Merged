package com.drivego.payment;

import jakarta.persistence.*;

@Entity
@Table(name = "payment_methods")
public class PaymentMethod {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "method_id")
    private Integer methodId;
    
    @Column(name = "method_name", nullable = false, length = 50)
    private String methodName;
    
    @Column(name = "description", length = 255)
    private String description;
    
    @Column(name = "is_active")
    private Boolean isActive = true;
    
    // Default constructor
    public PaymentMethod() {}
    
    // Parameterized constructor
    public PaymentMethod(String methodName, String description) {
        this.methodName = methodName;
        this.description = description;
        this.isActive = true;
    }
    
    // Getters and Setters
    public Integer getMethodId() {
        return methodId;
    }
    
    public void setMethodId(Integer methodId) {
        this.methodId = methodId;
    }
    
    public String getMethodName() {
        return methodName;
    }
    
    public void setMethodName(String methodName) {
        this.methodName = methodName;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public Boolean getIsActive() {
        return isActive;
    }
    
    public void setIsActive(Boolean isActive) {
        this.isActive = isActive;
    }
}
