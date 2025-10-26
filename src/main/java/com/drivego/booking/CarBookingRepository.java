package com.drivego.booking;

import com.drivego.booking.CarBookingModel;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Repository
public interface CarBookingRepository extends JpaRepository<CarBookingModel, Long> {
    
    // Find all bookings that are not deleted
    List<CarBookingModel> findByDeleteStatusFalse();
    
    // Find all bookings that are not deleted with pagination
    Page<CarBookingModel> findByDeleteStatusFalse(Pageable pageable);
    
    // Find booking by id and not deleted
    Optional<CarBookingModel> findByIdAndDeleteStatusFalse(Long id);
    
    // Find bookings by car id and not deleted
    List<CarBookingModel> findByCarIdAndDeleteStatusFalse(Long carId);
    
    // Find bookings by email and not deleted
    List<CarBookingModel> findByBookedEmailAndDeleteStatusFalse(String bookedEmail);
    
    // Find bookings by vehicle registration number
    List<CarBookingModel> findByVehicleRegNoAndDeleteStatusFalse(String vehicleRegNo);
    
    // Check if car is already booked for a specific date
    @Query("SELECT COUNT(b) > 0 FROM CarBookingModel b WHERE b.carId = :carId AND b.bookingDate = :bookingDate AND b.deleteStatus = false AND b.status != 'CANCELLED'")
    boolean isCarAlreadyBooked(@Param("carId") Long carId, @Param("bookingDate") Date bookingDate);

    // Find bookings by contact person name and not deleted
    List<CarBookingModel> findByContactPersonNameContainingIgnoreCaseAndDeleteStatusFalse(String contactPersonName);

    // Find bookings by date range and not deleted
    List<CarBookingModel> findByBookingDateBetweenAndDeleteStatusFalse(Date startDate, Date endDate);

    // Find bookings by status and not deleted
    List<CarBookingModel> findByStatusAndDeleteStatusFalse(String status);

    // Search bookings with multiple criteria
    @Query("SELECT b FROM CarBookingModel b WHERE " +
           "(:carId IS NULL OR b.carId = :carId) AND " +
           "(:email IS NULL OR b.bookedEmail LIKE %:email%) AND " +
           "(:contactName IS NULL OR b.contactPersonName LIKE %:contactName%) AND " +
           "b.deleteStatus = false")
    Page<CarBookingModel> searchBookings(@Param("carId") Long carId,
                                        @Param("email") String email,
                                        @Param("contactName") String contactName,
                                        Pageable pageable);

    // Count bookings by status
    @Query("SELECT COUNT(b) FROM CarBookingModel b WHERE b.status = :status AND b.deleteStatus = false")
    long countByStatus(@Param("status") String status);

    // Find recent bookings
    @Query("SELECT b FROM CarBookingModel b WHERE b.deleteStatus = false ORDER BY b.id DESC")
    List<CarBookingModel> findRecentBookings(Pageable pageable);
}