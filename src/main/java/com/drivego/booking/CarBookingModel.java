package com.drivego.booking;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "car_bookings")
public class CarBookingModel {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;
    
    @Column(name = "car_id", nullable = false)
    private Long carId;
    
    @Column(name = "vehicle_reg_no")
    private String vehicleRegNo;
    
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "booking_date", nullable = false)
    private Date bookingDate;
    
    @Temporal(TemporalType.DATE)
    @Column(name = "pickup_date")
    private Date pickupDate;
    
    @Temporal(TemporalType.DATE)
    @Column(name = "return_date")
    private Date returnDate;
    
    @Column(name = "pickup_location")
    private String pickupLocation;
    
    @Column(name = "booked_email", nullable = false)
    private String bookedEmail;
    
    @Column(name = "additional_notes")
    private String additionalNotes;
    
    @Column(name = "contact_number", nullable = false)
    private String contactNumber;
    
    @Column(name = "contact_person_name", nullable = false)
    private String contactPersonName;
    
    @Column(name = "delete_status", nullable = false)
    private boolean deleteStatus = false;

    @Column(name = "status")
    private String status = "PENDING";

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_at")
    private Date createdAt;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "updated_at")
    private Date updatedAt;

    // Default constructor
    public CarBookingModel() {
        this.createdAt = new Date();
        this.updatedAt = new Date();
    }
    
    // Parameterized constructor
    public CarBookingModel(Long carId, Date bookingDate, String bookedEmail, String additionalNotes, 
                          String contactNumber, String contactPersonName) {
        this.carId = carId;
        this.bookingDate = bookingDate;
        this.bookedEmail = bookedEmail;
        this.additionalNotes = additionalNotes;
        this.contactNumber = contactNumber;
        this.contactPersonName = contactPersonName;
        this.deleteStatus = false;
        this.status = "PENDING";
        this.createdAt = new Date();
        this.updatedAt = new Date();
    }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public Long getCarId() {
        return carId;
    }
    
    public void setCarId(Long carId) {
        this.carId = carId;
    }
    
    public String getVehicleRegNo() {
        return vehicleRegNo;
    }
    
    public void setVehicleRegNo(String vehicleRegNo) {
        this.vehicleRegNo = vehicleRegNo;
    }
    
    public Date getPickupDate() {
        return pickupDate;
    }
    
    public void setPickupDate(Date pickupDate) {
        this.pickupDate = pickupDate;
    }
    
    public Date getReturnDate() {
        return returnDate;
    }
    
    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }
    
    public String getPickupLocation() {
        return pickupLocation;
    }
    
    public void setPickupLocation(String pickupLocation) {
        this.pickupLocation = pickupLocation;
    }
    
    public Date getBookingDate() {
        return bookingDate;
    }
    
    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }
    
    public String getBookedEmail() {
        return bookedEmail;
    }
    
    public void setBookedEmail(String bookedEmail) {
        this.bookedEmail = bookedEmail;
    }
    
    public String getAdditionalNotes() {
        return additionalNotes;
    }
    
    public void setAdditionalNotes(String additionalNotes) {
        this.additionalNotes = additionalNotes;
    }
    
    public String getContactNumber() {
        return contactNumber;
    }
    
    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }
    
    public String getContactPersonName() {
        return contactPersonName;
    }
    
    public void setContactPersonName(String contactPersonName) {
        this.contactPersonName = contactPersonName;
    }
    
    public boolean isDeleteStatus() {
        return deleteStatus;
    }
    
    public void setDeleteStatus(boolean deleteStatus) {
        this.deleteStatus = deleteStatus;
    }
    
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
        this.updatedAt = new Date();
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    @PrePersist
    protected void onCreate() {
        createdAt = new Date();
        updatedAt = new Date();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = new Date();
    }

    @Override
    public String toString() {
        return "CarBookingModel{" +
                "id=" + id +
                ", carId=" + carId +
                ", bookingDate=" + bookingDate +
                ", bookedEmail='" + bookedEmail + '\'' +
                ", additionalNotes='" + additionalNotes + '\'' +
                ", contactNumber='" + contactNumber + '\'' +
                ", contactPersonName='" + contactPersonName + '\'' +
                ", deleteStatus=" + deleteStatus +
                ", status='" + status + '\'' +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}
