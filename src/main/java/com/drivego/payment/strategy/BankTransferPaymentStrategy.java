package com.drivego.payment.strategy;

import org.springframework.stereotype.Component;
import java.util.UUID;
import java.util.regex.Pattern;

/**
 * STRATEGY PATTERN - Concrete Strategy Implementation
 * 
 * Concrete implementation for Bank Transfer payment processing
 * 
 * Implements the PaymentStrategy interface with bank transfer-specific logic
 */
@Component
public class BankTransferPaymentStrategy implements PaymentStrategy {
    
    // Bank account validation pattern (10-12 digits)
    private static final Pattern ACCOUNT_PATTERN = Pattern.compile("^\\d{10,12}$");
    
    @Override
    public PaymentResult processPayment(double amount, String paymentDetails) {
        try {
            if (!validatePaymentDetails(paymentDetails)) {
                return new PaymentResult(false, null, 
                    "Invalid bank account number", getPaymentMethodName());
            }
            
            // Simulate bank transfer processing
            String transactionId = "BT-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            
            // Log payment processing (in real app, would call banking API)
            System.out.println("Processing Bank Transfer:");
            System.out.println("  Amount: LKR " + String.format("%.2f", amount));
            System.out.println("  Account: " + maskAccountNumber(paymentDetails));
            System.out.println("  Transaction ID: " + transactionId);
            System.out.println("  Status: Pending verification");
            
            return new PaymentResult(true, transactionId, 
                "Bank transfer initiated successfully. Verification pending.", getPaymentMethodName());
                
        } catch (Exception e) {
            return new PaymentResult(false, null, 
                "Bank transfer processing failed: " + e.getMessage(), getPaymentMethodName());
        }
    }
    
    @Override
    public String getPaymentMethodName() {
        return "Bank Transfer";
    }
    
    @Override
    public boolean validatePaymentDetails(String paymentDetails) {
        return paymentDetails != null && ACCOUNT_PATTERN.matcher(paymentDetails).matches();
    }
    
    /**
     * Mask account number for security
     */
    private String maskAccountNumber(String accountNumber) {
        if (accountNumber.length() <= 4) return accountNumber;
        int visibleDigits = 4;
        String masked = "*".repeat(accountNumber.length() - visibleDigits);
        return masked + accountNumber.substring(accountNumber.length() - visibleDigits);
    }
}
