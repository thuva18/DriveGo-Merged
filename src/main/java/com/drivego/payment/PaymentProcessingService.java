package com.drivego.payment;

import com.drivego.payment.strategy.*;
import org.springframework.stereotype.Service;

/**
 * PaymentProcessingService - Demonstrates Strategy Pattern usage
 * 
 * This service shows how to use the Strategy Pattern to process payments
 * using different payment methods dynamically.
 */
@Service
public class PaymentProcessingService {
    
    private final PaymentContext paymentContext;
    private final CreditCardPaymentStrategy creditCardStrategy;
    private final BankTransferPaymentStrategy bankTransferStrategy;
    private final CashPaymentStrategy cashStrategy;
    
    public PaymentProcessingService(
            PaymentContext paymentContext,
            CreditCardPaymentStrategy creditCardStrategy,
            BankTransferPaymentStrategy bankTransferStrategy,
            CashPaymentStrategy cashStrategy) {
        
        this.paymentContext = paymentContext;
        this.creditCardStrategy = creditCardStrategy;
        this.bankTransferStrategy = bankTransferStrategy;
        this.cashStrategy = cashStrategy;
    }
    
    /**
     * Process payment using Strategy Pattern
     * 
     * This method demonstrates the Strategy Pattern:
     * - Selects appropriate payment strategy based on method
     * - Delegates processing to the strategy
     * - No if-else chains for different payment types
     * 
     * @param paymentMethod Payment method ("credit-card", "bank-transfer", "cash")
     * @param amount Payment amount in LKR
     * @param paymentDetails Payment-specific details
     * @return PaymentResult with transaction information
     */
    public PaymentResult processPayment(String paymentMethod, double amount, String paymentDetails) {
        try {
            // Strategy Pattern: Select appropriate strategy
            PaymentStrategy strategy = selectPaymentStrategy(paymentMethod);
            
            // Set the strategy in the context
            paymentContext.setPaymentStrategy(strategy);
            
            // Execute payment using the selected strategy
            return paymentContext.executePayment(amount, paymentDetails);
            
        } catch (IllegalArgumentException e) {
            return new PaymentResult(false, null, 
                "Invalid payment method: " + paymentMethod + 
                ". Supported methods: credit-card, bank-transfer, cash", 
                paymentMethod);
        }
    }
    
    /**
     * Select appropriate payment strategy based on method name
     * 
     * @param paymentMethod Payment method identifier
     * @return Concrete PaymentStrategy implementation
     * @throws IllegalArgumentException if payment method is not supported
     */
    private PaymentStrategy selectPaymentStrategy(String paymentMethod) {
        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            throw new IllegalArgumentException("Payment method cannot be null or empty");
        }
        
        return switch (paymentMethod.toLowerCase().trim()) {
            case "credit-card", "creditcard", "card" -> creditCardStrategy;
            case "bank-transfer", "banktransfer", "bank" -> bankTransferStrategy;
            case "cash" -> cashStrategy;
            default -> throw new IllegalArgumentException("Unsupported payment method: " + paymentMethod);
        };
    }
    
    /**
     * Validate payment details for a specific method
     * 
     * @param paymentMethod Payment method
     * @param paymentDetails Details to validate
     * @return true if valid, false otherwise
     */
    public boolean validatePaymentDetails(String paymentMethod, String paymentDetails) {
        try {
            PaymentStrategy strategy = selectPaymentStrategy(paymentMethod);
            return strategy.validatePaymentDetails(paymentDetails);
        } catch (IllegalArgumentException e) {
            return false;
        }
    }
}
