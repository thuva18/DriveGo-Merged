package com.drivego.payment.strategy;

import org.springframework.stereotype.Component;

/**
 * STRATEGY PATTERN - Context Class
 * 
 * Context that uses a PaymentStrategy to process payments
 * 
 * This is the context class in the Strategy Pattern that:
 * - Maintains a reference to a Strategy object
 * - Allows clients to select which strategy to use
 * - Delegates payment processing to the chosen strategy
 * 
 * Usage Example:
 * <pre>
 * PaymentContext context = new PaymentContext();
 * context.setPaymentStrategy(creditCardStrategy);
 * PaymentResult result = context.executePayment(5000.0, "1234567812345678");
 * </pre>
 */
@Component
public class PaymentContext {
    
    private PaymentStrategy paymentStrategy;
    
    /**
     * Set the payment strategy to use
     * 
     * @param paymentStrategy The payment strategy to use (Credit Card, Bank Transfer, Cash)
     */
    public void setPaymentStrategy(PaymentStrategy paymentStrategy) {
        this.paymentStrategy = paymentStrategy;
    }
    
    /**
     * Execute payment using the currently selected strategy
     * 
     * @param amount Payment amount in LKR
     * @param paymentDetails Payment-specific details (card number, account number, etc.)
     * @return PaymentResult containing transaction details
     * @throws IllegalStateException if no payment strategy is set
     */
    public PaymentResult executePayment(double amount, String paymentDetails) {
        if (paymentStrategy == null) {
            throw new IllegalStateException("Payment strategy not set. Please set a payment strategy before processing.");
        }
        
        System.out.println("\n=== STRATEGY PATTERN IN ACTION ===");
        System.out.println("Selected Payment Method: " + paymentStrategy.getPaymentMethodName());
        
        PaymentResult result = paymentStrategy.processPayment(amount, paymentDetails);
        
        System.out.println("Payment Status: " + (result.isSuccess() ? "SUCCESS" : "FAILED"));
        System.out.println("===================================\n");
        
        return result;
    }
    
    /**
     * Get current payment strategy name
     * 
     * @return Name of current payment strategy or null if not set
     */
    public String getCurrentStrategyName() {
        return paymentStrategy != null ? paymentStrategy.getPaymentMethodName() : null;
    }
}
