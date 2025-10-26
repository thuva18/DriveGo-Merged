package com.drivego.payment;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "creditcard_payments")
public class CreditCardPayment {
    
    @Id
    @Column(name = "payment_id")
    private Integer paymentId;
    
    @Column(name = "card_holder", length = 100)
    private String cardHolder;
    
    @Column(name = "card_number", length = 30)
    private String cardNumber;
    
    @Temporal(TemporalType.DATE)
    @Column(name = "expiry_date")
    private Date expiryDate;
    
    @Column(name = "method_id")
    private Integer methodId;
    
    // Default constructor
    public CreditCardPayment() {
    }
    
    // Parameterized constructor
    public CreditCardPayment(Integer paymentId, String cardHolder, String cardNumber, 
                            Date expiryDate, Integer methodId) {
        this.paymentId = paymentId;
        this.cardHolder = cardHolder;
        this.cardNumber = cardNumber;
        this.expiryDate = expiryDate;
        this.methodId = methodId;
    }
    
    // Getters and Setters
    public Integer getPaymentId() {
        return paymentId;
    }
    
    public void setPaymentId(Integer paymentId) {
        this.paymentId = paymentId;
    }
    
    public String getCardHolder() {
        return cardHolder;
    }
    
    public void setCardHolder(String cardHolder) {
        this.cardHolder = cardHolder;
    }
    
    public String getCardNumber() {
        return cardNumber;
    }
    
    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }
    
    public Date getExpiryDate() {
        return expiryDate;
    }
    
    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }
    
    public Integer getMethodId() {
        return methodId;
    }
    
    public void setMethodId(Integer methodId) {
        this.methodId = methodId;
    }
}
