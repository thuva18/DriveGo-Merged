package com.drivego.payment.strategy;

import org.springframework.stereotype.Component;
import java.util.UUID;
import java.util.regex.Pattern;

/**
 * STRATEGY PATTERN - Concrete Strategy Implementation
 * 
 * Concrete implementation for Credit Card payment processing
 * 
 * Implements the PaymentStrategy interface with credit card-specific logic
 */
@Component
public class CreditCardPaymentStrategy implements PaymentStrategy {
    
    // Credit card validation pattern (16 digits)
    private static final Pattern CARD_PATTERN = Pattern.compile("^\\d{16}$");
    
    @Override
    public PaymentResult processPayment(double amount, String paymentDetails) {
        try {
            // Simulate credit card processing
            if (!validatePaymentDetails(paymentDetails)) {
                return new PaymentResult(false, null, 
                    "Invalid credit card number", getPaymentMethodName());
            }
            
            // Simulate payment gateway processing
            String transactionId = "CC-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            
            // Log payment processing (in real app, would call payment gateway API)
            System.out.println("Processing Credit Card Payment:");
            System.out.println("  Amount: LKR " + String.format("%.2f", amount));
            System.out.println("  Card: **** **** **** " + paymentDetails.substring(12));
            System.out.println("  Transaction ID: " + transactionId);
            
            return new PaymentResult(true, transactionId, 
                "Credit card payment processed successfully", getPaymentMethodName());
                
        } catch (Exception e) {
            return new PaymentResult(false, null, 
                "Credit card processing failed: " + e.getMessage(), getPaymentMethodName());
        }
    }
    
    @Override
    public String getPaymentMethodName() {
        return "Credit Card";
    }
    
    @Override
    public boolean validatePaymentDetails(String paymentDetails) {
        return paymentDetails != null && CARD_PATTERN.matcher(paymentDetails).matches();
    }
}
