package com.drivego.payment;

import jakarta.persistence.*;

@Entity
@Table(name = "debitcard_payments")
public class DebitCardPayment {
    
    @Id
    @Column(name = "payment_id")
    private Integer paymentId;
    
    @Column(name = "card_holder", length = 100)
    private String cardHolder;
    
    @Column(name = "card_number", length = 30)
    private String cardNumber;
    
    @Column(name = "bank", length = 100)
    private String bank;
    
    @Column(name = "method_id")
    private Integer methodId;
    
    // Default constructor
    public DebitCardPayment() {
    }
    
    // Parameterized constructor
    public DebitCardPayment(Integer paymentId, String cardHolder, String cardNumber, 
                           String bank, Integer methodId) {
        this.paymentId = paymentId;
        this.cardHolder = cardHolder;
        this.cardNumber = cardNumber;
        this.bank = bank;
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
    
    public String getBank() {
        return bank;
    }
    
    public void setBank(String bank) {
        this.bank = bank;
    }
    
    public Integer getMethodId() {
        return methodId;
    }
    
    public void setMethodId(Integer methodId) {
        this.methodId = methodId;
    }
}
