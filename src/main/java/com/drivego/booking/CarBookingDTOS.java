package com.drivego.booking;

import jakarta.validation.constraints.*;
import java.util.Date;
import java.util.List;

public class CarBookingDTOS {

    // Request DTO for creating a new booking
    public static class CreateRequest {
        @NotNull(message = "Vehicle selection is required")
        @Min(value = 1, message = "Please select a valid vehicle")
        private Long carId;
        
        @NotNull(message = "Booking date is required")
        @Future(message = "Booking date must be in the future")
        private Date bookingDate;
        
        @NotBlank(message = "Email address is required")
        @Email(message = "Please enter a valid email address")
        @Size(max = 100, message = "Email address is too long")
        private String bookedEmail;
        
        @Size(max = 500, message = "Additional notes cannot exceed 500 characters")
        private String additionalNotes;
        
        @NotBlank(message = "Contact number is required")
        @Pattern(regexp = "^[+]?[1-9][\\d]{0,15}$", message = "Please enter a valid phone number")
        private String contactNumber;
        
        @NotBlank(message = "Contact person name is required")
        @Size(min = 2, max = 100, message = "Name must be between 2 and 100 characters")
        @Pattern(regexp = "^[a-zA-Z\\s]+$", message = "Name should contain only letters and spaces")
        private String contactPersonName;

        // Default constructor
        public CreateRequest() {
        }

        // Getters and Setters
        public Long getCarId() {
            return carId;
        }

        public void setCarId(Long carId) {
            this.carId = carId;
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
    }

    // Request DTO for updating an existing booking
    public static class UpdateRequest {
        @NotNull(message = "Booking ID is required")
        @Min(value = 1, message = "Invalid booking ID")
        private Long id;
        
        @NotNull(message = "Vehicle selection is required")
        @Min(value = 1, message = "Please select a valid vehicle")
        private Long carId;
        
        @NotNull(message = "Booking date is required")
        private Date bookingDate;
        
        @NotBlank(message = "Email address is required")
        @Email(message = "Please enter a valid email address")
        @Size(max = 100, message = "Email address is too long")
        private String bookedEmail;
        
        @Size(max = 500, message = "Additional notes cannot exceed 500 characters")
        private String additionalNotes;
        
        @NotBlank(message = "Contact number is required")
        @Pattern(regexp = "^[+]?[1-9][\\d]{0,15}$", message = "Please enter a valid phone number")
        private String contactNumber;
        
        @NotBlank(message = "Contact person name is required")
        @Size(min = 2, max = 100, message = "Name must be between 2 and 100 characters")
        @Pattern(regexp = "^[a-zA-Z\\s]+$", message = "Name should contain only letters and spaces")
        private String contactPersonName;
        
        @Pattern(regexp = "^(PENDING|CONFIRMED|COMPLETED|CANCELLED)$", message = "Invalid status")
        private String status;
        
        @NotBlank(message = "Vehicle registration number is required")
        @Pattern(regexp = "^[A-Z]{2,3}[-\\s]?\\d{4}$", message = "Invalid registration number format")
        private String vehicleRegNo;
        
        @Future(message = "Pickup date must be in the future")
        private Date pickupDate;
        
        @Future(message = "Return date must be in the future")
        private Date returnDate;
        
        @NotBlank(message = "Pickup location is required")
        @Size(min = 3, max = 200, message = "Pickup location must be between 3 and 200 characters")
        private String pickupLocation;

        // Default constructor
        public UpdateRequest() {
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

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
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
    }

    // Response DTO for returning booking data
    public static class Response {
        private Long id;
        private Long carId;
        private String vehicleRegNo;
        private Date bookingDate;
        private Date pickupDate;
        private Date returnDate;
        private String pickupLocation;
        private String bookedEmail;
        private String additionalNotes;
        private String contactNumber;
        private String contactPersonName;
        private String status;
        private boolean deleteStatus;
        private Date createdAt;
        private Date updatedAt;

        // Default constructor
        public Response() {
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

        public Date getBookingDate() {
            return bookingDate;
        }

        public void setBookingDate(Date bookingDate) {
            this.bookingDate = bookingDate;
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

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
        }

        public boolean isDeleteStatus() {
            return deleteStatus;
        }

        public void setDeleteStatus(boolean deleteStatus) {
            this.deleteStatus = deleteStatus;
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
    }

    // List response DTO for paginated results
    public static class ListResponse {
        private List<Response> bookings;
        private int totalElements;
        private int totalPages;
        private int currentPage;
        private int size;

        // Default constructor
        public ListResponse() {
        }

        // Constructor with parameters
        public ListResponse(List<Response> bookings, int totalElements, int currentPage, int size) {
            this.bookings = bookings;
            this.totalElements = totalElements;
            this.currentPage = currentPage;
            this.size = size;
            this.totalPages = (int) Math.ceil((double) totalElements / size);
        }

        // Getters and Setters
        public List<Response> getBookings() {
            return bookings;
        }

        public void setBookings(List<Response> bookings) {
            this.bookings = bookings;
        }

        public int getTotalElements() {
            return totalElements;
        }

        public void setTotalElements(int totalElements) {
            this.totalElements = totalElements;
        }

        public int getTotalPages() {
            return totalPages;
        }

        public void setTotalPages(int totalPages) {
            this.totalPages = totalPages;
        }

        public int getCurrentPage() {
            return currentPage;
        }

        public void setCurrentPage(int currentPage) {
            this.currentPage = currentPage;
        }

        public int getSize() {
            return size;
        }

        public void setSize(int size) {
            this.size = size;
        }
    }

    // Generic response DTO for operations
    public static class GenericResponse {
        private boolean success;
        private String message;

        // Default constructor
        public GenericResponse() {
        }

        // Constructor with parameters
        public GenericResponse(boolean success, String message) {
            this.success = success;
            this.message = message;
        }

        // Getters and Setters
        public boolean isSuccess() {
            return success;
        }

        public void setSuccess(boolean success) {
            this.success = success;
        }

        public String getMessage() {
            return message;
        }

        public void setMessage(String message) {
            this.message = message;
        }
    }
}