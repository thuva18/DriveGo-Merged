package com.drivego.config;

import com.drivego.payment.PaymentMethod;
import com.drivego.payment.PaymentMethodRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class PaymentMethodDataInitializer implements CommandLineRunner {

    @Autowired
    private PaymentMethodRepository paymentMethodRepository;

    @Override
    public void run(String... args) throws Exception {
        // Check if payment methods already exist
        if (paymentMethodRepository.count() == 0) {
            // Create default payment methods
            PaymentMethod cash = new PaymentMethod("Cash", "Pay with cash at pickup");
            PaymentMethod creditCard = new PaymentMethod("Credit Card", "Visa, MasterCard, Amex");
            PaymentMethod debitCard = new PaymentMethod("Debit Card", "Direct debit from your account");
            PaymentMethod bankTransfer = new PaymentMethod("Bank Transfer", "Transfer directly to our account");
            
            paymentMethodRepository.save(cash);
            paymentMethodRepository.save(creditCard);
            paymentMethodRepository.save(debitCard);
            paymentMethodRepository.save(bankTransfer);
            
            System.out.println("✅ Payment methods initialized successfully!");
        }
    }
}
