package com.drivego.payment;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "bank_payment_slips")
public class BankPaymentSlip {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "slip_id")
    private Long slipId;
    
    @Column(name = "payment_id")
    private Integer paymentId;
    
    @Column(name = "car_booking_id")
    private Long carBookingId;
    
    @Column(name = "user_email", nullable = false)
    private String userEmail;
    
    @Column(name = "slip_filename", nullable = false)
    private String slipFilename;
    
    @Column(name = "file_path")
    private String filePath;
    
    @Column(name = "file_size")
    private Long fileSize;
    
    @Column(name = "upload_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date uploadDate;
    
    @Column(name = "verification_status")
    private String verificationStatus = "PENDING"; // PENDING, VERIFIED, REJECTED
    
    @Column(name = "verified_by")
    private String verifiedBy;
    
    @Column(name = "verified_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date verifiedDate;
    
    @Column(name = "notes")
    private String notes;
    
    // Default constructor
    public BankPaymentSlip() {
        this.uploadDate = new Date();
        this.verificationStatus = "PENDING";
    }
    
    // Parameterized constructor
    public BankPaymentSlip(Integer paymentId, Long carBookingId, String userEmail, 
                          String slipFilename, String filePath, Long fileSize) {
        this.paymentId = paymentId;
        this.carBookingId = carBookingId;
        this.userEmail = userEmail;
        this.slipFilename = slipFilename;
        this.filePath = filePath;
        this.fileSize = fileSize;
        this.uploadDate = new Date();
        this.verificationStatus = "PENDING";
    }
    
    // Getters and Setters
    public Long getSlipId() {
        return slipId;
    }
    
    public void setSlipId(Long slipId) {
        this.slipId = slipId;
    }
    
    public Integer getPaymentId() {
        return paymentId;
    }
    
    public void setPaymentId(Integer paymentId) {
        this.paymentId = paymentId;
    }
    
    public Long getCarBookingId() {
        return carBookingId;
    }
    
    public void setCarBookingId(Long carBookingId) {
        this.carBookingId = carBookingId;
    }
    
    public String getUserEmail() {
        return userEmail;
    }
    
    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }
    
    public String getSlipFilename() {
        return slipFilename;
    }
    
    public void setSlipFilename(String slipFilename) {
        this.slipFilename = slipFilename;
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
    
    public Date getUploadDate() {
        return uploadDate;
    }
    
    public void setUploadDate(Date uploadDate) {
        this.uploadDate = uploadDate;
    }
    
    public String getVerificationStatus() {
        return verificationStatus;
    }
    
    public void setVerificationStatus(String verificationStatus) {
        this.verificationStatus = verificationStatus;
    }
    
    public String getVerifiedBy() {
        return verifiedBy;
    }
    
    public void setVerifiedBy(String verifiedBy) {
        this.verifiedBy = verifiedBy;
    }
    
    public Date getVerifiedDate() {
        return verifiedDate;
    }
    
    public void setVerifiedDate(Date verifiedDate) {
        this.verifiedDate = verifiedDate;
    }
    
    public String getNotes() {
        return notes;
    }
    
    public void setNotes(String notes) {
        this.notes = notes;
    }
}
