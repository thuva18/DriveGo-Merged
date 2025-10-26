package com.drivego.payment;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "bank_transfer_receipts")
public class BankTransferReceipt {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "receipt_id")
    private Integer receiptId;
    
    @Column(name = "payment_id", nullable = false)
    private Integer paymentId;
    
    @Column(name = "filename", nullable = false, length = 255)
    private String filename;
    
    @Column(name = "file_path", nullable = false, length = 500)
    private String filePath;
    
    @Column(name = "file_size")
    private Long fileSize;
    
    @Column(name = "upload_date", nullable = false)
    private LocalDateTime uploadDate;
    
    public BankTransferReceipt() {
        this.uploadDate = LocalDateTime.now();
    }
    
    public BankTransferReceipt(Integer paymentId, String filename, String filePath, Long fileSize) {
        this();
        this.paymentId = paymentId;
        this.filename = filename;
        this.filePath = filePath;
        this.fileSize = fileSize;
    }
    
    // Getters and Setters
    public Integer getReceiptId() {
        return receiptId;
    }
    
    public void setReceiptId(Integer receiptId) {
        this.receiptId = receiptId;
    }
    
    public Integer getPaymentId() {
        return paymentId;
    }
    
    public void setPaymentId(Integer paymentId) {
        this.paymentId = paymentId;
    }
    
    public String getFilename() {
        return filename;
    }
    
    public void setFilename(String filename) {
        this.filename = filename;
    }
    
    public String getFilePath() {
        return filePath;
    }
    
    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }
    
    public Long getFileSize() {
        return fileSize;
    }
    
    public void setFileSize(Long fileSize) {
        this.fileSize = fileSize;
    }
    
    public LocalDateTime getUploadDate() {
        return uploadDate;
    }
    
    public void setUploadDate(LocalDateTime uploadDate) {
        this.uploadDate = uploadDate;
    }
}
