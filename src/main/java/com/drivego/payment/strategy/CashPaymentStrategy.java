package com.drivego.payment.strategy;

import org.springframework.stereotype.Component;
import java.util.UUID;

/**
 * STRATEGY PATTERN - Concrete Strategy Implementation
 * 
 * Concrete implementation for Cash payment processing
 * 
 * Implements the PaymentStrategy interface with cash payment-specific logic
 */
@Component
public class CashPaymentStrategy implements PaymentStrategy {
    
    @Override
    public PaymentResult processPayment(double amount, String paymentDetails) {
        try {
            // For cash payments, paymentDetails might be empty or contain notes
            // Simulate cash payment recording
            String transactionId = "CASH-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            
            // Log payment processing
            System.out.println("Processing Cash Payment:");
            System.out.println("  Amount: LKR " + String.format("%.2f", amount));
            System.out.println("  Receipt ID: " + transactionId);
            if (paymentDetails != null && !paymentDetails.isEmpty()) {
                System.out.println("  Notes: " + paymentDetails);
            }
            
            return new PaymentResult(true, transactionId, 
                "Cash payment recorded successfully", getPaymentMethodName());
                
        } catch (Exception e) {
            return new PaymentResult(false, null, 
                "Cash payment recording failed: " + e.getMessage(), getPaymentMethodName());
        }
    }
    
    @Override
    public String getPaymentMethodName() {
        return "Cash";
    }
    
    @Override
    public boolean validatePaymentDetails(String paymentDetails) {
        // Cash payments don't require specific validation
        // Payment details can be optional notes
        return true;
    }
}
