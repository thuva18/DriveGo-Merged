package com.drivego.payment.strategy;

/**
 * DESIGN PATTERN: STRATEGY PATTERN
 * 
 * Strategy Interface for different payment processing methods.
 * 
 * Pattern Purpose:
 * - Defines a family of payment algorithms (Credit Card, Bank Transfer, Cash)
 * - Encapsulates each payment method
 * - Makes payment methods interchangeable
 * 
 * Benefits:
 * - Easy to add new payment methods without modifying existing code
 * - Eliminates conditional statements for payment processing
 * - Follows Open/Closed Principle (open for extension, closed for modification)
 */
public interface PaymentStrategy {
    
    /**
     * Process payment using specific strategy
     * 
     * @param amount Payment amount in LKR
     * @param paymentDetails Additional payment details (card number, account number, etc.)
     * @return PaymentResult containing success status and transaction ID
     */
    PaymentResult processPayment(double amount, String paymentDetails);
    
    /**
     * Get payment method name
     * 
     * @return Name of the payment method (e.g., "Credit Card", "Bank Transfer")
     */
    String getPaymentMethodName();
    
    /**
     * Validate payment details before processing
     * 
     * @param paymentDetails Payment details to validate
     * @return true if valid, false otherwise
     */
    boolean validatePaymentDetails(String paymentDetails);
}
