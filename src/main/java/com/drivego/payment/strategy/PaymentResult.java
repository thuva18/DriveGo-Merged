package com.drivego.payment.strategy;

/**
 * Result object returned after payment processing
 */
public class PaymentResult {
    private boolean success;
    private String transactionId;
    private String message;
    private String paymentMethod;
    
    public PaymentResult(boolean success, String transactionId, String message, String paymentMethod) {
        this.success = success;
        this.transactionId = transactionId;
        this.message = message;
        this.paymentMethod = paymentMethod;
    }
    
    // Getters and setters
    public boolean isSuccess() {
        return success;
    }
    
    public void setSuccess(boolean success) {
        this.success = success;
    }
    
    public String getTransactionId() {
        return transactionId;
    }
    
    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }
    
    public String getMessage() {
        return message;
    }
    
    public void setMessage(String message) {
        this.message = message;
    }
    
    public String getPaymentMethod() {
        return paymentMethod;
    }
    
    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }
    
    @Override
    public String toString() {
        return "PaymentResult{" +
                "success=" + success +
                ", transactionId='" + transactionId + '\'' +
                ", message='" + message + '\'' +
                ", paymentMethod='" + paymentMethod + '\'' +
                '}';
    }
}
