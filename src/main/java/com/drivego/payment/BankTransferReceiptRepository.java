package com.drivego.payment;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BankTransferReceiptRepository extends JpaRepository<BankTransferReceipt, Integer> {
    
    List<BankTransferReceipt> findByPaymentId(Integer paymentId);
}
