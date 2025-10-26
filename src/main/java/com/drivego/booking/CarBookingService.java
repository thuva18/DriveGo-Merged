package com.drivego.booking;

import com.drivego.booking.CarBookingDTOS;
import com.drivego.booking.CarBookingModel;
import com.drivego.booking.CarBookingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class CarBookingService {
    
    private final CarBookingRepository carBookingRepository;
    
    @Autowired
    public CarBookingService(CarBookingRepository carBookingRepository) {
        this.carBookingRepository = carBookingRepository;
    }
    
    // Create a new booking
    @Transactional
    public CarBookingDTOS.Response createBooking(CarBookingDTOS.CreateRequest request) {
        // Check if car is already booked for the requested date
        if (carBookingRepository.isCarAlreadyBooked(request.getCarId(), request.getBookingDate())) {
            throw new RuntimeException("Car is already booked for the selected date");
        }
        
        // Create new booking
        CarBookingModel booking = new CarBookingModel();
        booking.setCarId(request.getCarId());
        booking.setBookingDate(request.getBookingDate());
        booking.setBookedEmail(request.getBookedEmail());
        booking.setAdditionalNotes(request.getAdditionalNotes());
        booking.setContactNumber(request.getContactNumber());
        booking.setContactPersonName(request.getContactPersonName());
        booking.setDeleteStatus(false);
        
        // Save booking
        CarBookingModel savedBooking = carBookingRepository.save(booking);
        
        // Convert to response DTO
        return convertToResponseDTO(savedBooking);
    }
    
    // Get booking by ID
    public CarBookingDTOS.Response getBookingById(Long id) {
        Optional<CarBookingModel> bookingOpt = carBookingRepository.findByIdAndDeleteStatusFalse(id);
        
        if (bookingOpt.isPresent()) {
            return convertToResponseDTO(bookingOpt.get());
        } else {
            throw new RuntimeException("Booking not found with id: " + id);
        }
    }
    
    // Get all bookings with pagination
    public CarBookingDTOS.ListResponse getAllBookings(int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by("bookingDate").descending());
        Page<CarBookingModel> bookingsPage = carBookingRepository.findByDeleteStatusFalse(pageable);
        
        List<CarBookingDTOS.Response> bookingResponses = bookingsPage.getContent()
                .stream()
                .map(this::convertToResponseDTO)
                .collect(Collectors.toList());
        
        return new CarBookingDTOS.ListResponse(
                bookingResponses,
                (int) bookingsPage.getTotalElements(),
                bookingsPage.getNumber(),
                bookingsPage.getSize()
        );
    }
    
    // Update booking
    @Transactional
    public CarBookingDTOS.Response updateBooking(Long id, CarBookingDTOS.UpdateRequest request) {
        // Check if booking exists
        Optional<CarBookingModel> bookingOpt = carBookingRepository.findByIdAndDeleteStatusFalse(id);
        
        if (!bookingOpt.isPresent()) {
            throw new RuntimeException("Booking not found with id: " + id);
        }
        
        CarBookingModel booking = bookingOpt.get();
        
        // Update booking details
        if (request.getCarId() != null) {
            booking.setCarId(request.getCarId());
        }
        if (request.getBookingDate() != null) {
            booking.setBookingDate(request.getBookingDate());
        }
        if (request.getBookedEmail() != null) {
            booking.setBookedEmail(request.getBookedEmail());
        }
        if (request.getAdditionalNotes() != null) {
            booking.setAdditionalNotes(request.getAdditionalNotes());
        }
        if (request.getContactNumber() != null) {
            booking.setContactNumber(request.getContactNumber());
        }
        if (request.getContactPersonName() != null) {
            booking.setContactPersonName(request.getContactPersonName());
        }
        if (request.getStatus() != null) {
            booking.setStatus(request.getStatus());
        }
        if (request.getVehicleRegNo() != null) {
            booking.setVehicleRegNo(request.getVehicleRegNo());
        }
        if (request.getPickupDate() != null) {
            booking.setPickupDate(request.getPickupDate());
        }
        if (request.getReturnDate() != null) {
            booking.setReturnDate(request.getReturnDate());
        }
        if (request.getPickupLocation() != null) {
            booking.setPickupLocation(request.getPickupLocation());
        }
        
        booking.setUpdatedAt(new Date());
        
        // Save updated booking
        CarBookingModel updatedBooking = carBookingRepository.save(booking);
        
        // Convert to response DTO
        return convertToResponseDTO(updatedBooking);
    }
    
    // Update booking status
    @Transactional
    public CarBookingDTOS.Response updateBookingStatus(Long id, String status) {
        Optional<CarBookingModel> bookingOpt = carBookingRepository.findByIdAndDeleteStatusFalse(id);

        if (!bookingOpt.isPresent()) {
            throw new RuntimeException("Booking not found with id: " + id);
        }

        CarBookingModel booking = bookingOpt.get();
        booking.setStatus(status);
        booking.setUpdatedAt(new Date());

        CarBookingModel updatedBooking = carBookingRepository.save(booking);
        return convertToResponseDTO(updatedBooking);
    }

    // Delete booking (soft delete)
    @Transactional
    public CarBookingDTOS.GenericResponse deleteBooking(Long id) {
        Optional<CarBookingModel> bookingOpt = carBookingRepository.findByIdAndDeleteStatusFalse(id);
        
        if (!bookingOpt.isPresent()) {
            throw new RuntimeException("Booking not found with id: " + id);
        }
        
        CarBookingModel booking = bookingOpt.get();
        booking.setDeleteStatus(true);
        carBookingRepository.save(booking);
        
        return new CarBookingDTOS.GenericResponse(true, "Booking deleted successfully");
    }
    
    // Search bookings by criteria
    public CarBookingDTOS.ListResponse searchBookings(Long carId, String email, String contactName, int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by("bookingDate").descending());
        Page<CarBookingModel> bookingsPage = carBookingRepository.searchBookings(carId, email, contactName, pageable);
        
        List<CarBookingDTOS.Response> bookingResponses = bookingsPage.getContent()
                .stream()
                .map(this::convertToResponseDTO)
                .collect(Collectors.toList());
        
        return new CarBookingDTOS.ListResponse(
                bookingResponses,
                (int) bookingsPage.getTotalElements(),
                bookingsPage.getNumber(),
                bookingsPage.getSize()
        );
    }
    
    // Get bookings by car ID
    public List<CarBookingDTOS.Response> getBookingsByCarId(Long carId) {
        List<CarBookingModel> bookings = carBookingRepository.findByCarIdAndDeleteStatusFalse(carId);
        
        return bookings.stream()
                .map(this::convertToResponseDTO)
                .collect(Collectors.toList());
    }
    
    // Get bookings by date range
    public List<CarBookingDTOS.Response> getBookingsByDateRange(Date startDate, Date endDate) {
        List<CarBookingModel> bookings = carBookingRepository.findByBookingDateBetweenAndDeleteStatusFalse(startDate, endDate);
        
        return bookings.stream()
                .map(this::convertToResponseDTO)
                .collect(Collectors.toList());
    }
    
    // Helper method to convert model to DTO
    private CarBookingDTOS.Response convertToResponseDTO(CarBookingModel booking) {
        CarBookingDTOS.Response response = new CarBookingDTOS.Response();
        response.setId(booking.getId());
        response.setCarId(booking.getCarId());
        response.setVehicleRegNo(booking.getVehicleRegNo());
        response.setBookingDate(booking.getBookingDate());
        response.setPickupDate(booking.getPickupDate());
        response.setReturnDate(booking.getReturnDate());
        response.setPickupLocation(booking.getPickupLocation());
        response.setBookedEmail(booking.getBookedEmail());
        response.setAdditionalNotes(booking.getAdditionalNotes());
        response.setContactNumber(booking.getContactNumber());
        response.setContactPersonName(booking.getContactPersonName());
        response.setStatus(booking.getStatus());
        response.setDeleteStatus(booking.isDeleteStatus());
        response.setCreatedAt(booking.getCreatedAt());
        response.setUpdatedAt(booking.getUpdatedAt());

        return response;
    }

    // Get bookings by user email
    public List<CarBookingModel> getBookingsByEmail(String email) {
        return carBookingRepository.findByBookedEmailAndDeleteStatusFalse(email);
    }

    // Create booking directly from model (for customer use)
    @Transactional
    public CarBookingModel saveBooking(CarBookingModel booking) {
        return carBookingRepository.save(booking);
    }
}
