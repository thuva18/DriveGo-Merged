package com.drivego.payment;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BankPaymentSlipRepository extends JpaRepository<BankPaymentSlip, Long> {
    
    List<BankPaymentSlip> findByUserEmail(String userEmail);
    
    BankPaymentSlip findByPaymentId(Integer paymentId);
    
    List<BankPaymentSlip> findByVerificationStatus(String verificationStatus);
    
    List<BankPaymentSlip> findByCarBookingId(Long carBookingId);
}
