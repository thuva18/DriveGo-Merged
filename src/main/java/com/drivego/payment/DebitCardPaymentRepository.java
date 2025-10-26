package com.drivego.payment;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DebitCardPaymentRepository extends JpaRepository<DebitCardPayment, Integer> {
}
