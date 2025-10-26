package com.drivego.payment;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PaymentRepository extends JpaRepository<Payment, Integer> {
    
    List<Payment> findByBookingIdOrderByPaymentDateDesc(Long bookingId);
    
    Payment findByPaymentId(Integer paymentId);
}

