package com.drivego.payment;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PaymentMethodRepository extends JpaRepository<PaymentMethod, Integer> {
    
    // Find all active payment methods
    List<PaymentMethod> findByIsActiveTrue();
    
    // Find payment method by name
    PaymentMethod findByMethodName(String methodName);
}
