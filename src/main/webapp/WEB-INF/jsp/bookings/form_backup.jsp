<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../header.jsp" %>

<!-- Create Booking Page -->
<div class="page-header">
    <div>
        <h1 class="page-title">Create New Booking</h1>
        <p class="page-subtitle">Add a new vehicle booking to the system</p>
    </div>
    <div class="page-actions">
        <a href="<c:url value='/bookings'/>" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i>
            Back to Bookings
        </a>
    </div>
</div>

<!-- Flash Messages -->
<c:if test="${not empty error}">
    <div class="alert alert-danger">
        <i class="fas fa-exclamation-circle"></i>
        ${error}
    </div>
</c:if>

<!-- Booking Form -->
<div class="card">
    <div class="card-header">
        <h3><i class="fas fa-edit"></i> Booking Information</h3>
    </div>
    <div class="card-body">
        <form method="POST" action="/bookings" class="booking-form">
            <div class="form-grid">
                <div class="form-section">
                    <h4 class="form-section-title">Vehicle Details</h4>
                    <div class="form-group">
                        <label for="carId">Vehicle ID <span class="required">*</span></label>
                        <input type="number" class="form-control" id="carId" name="carId" required>
                        <small class="form-help">Enter the ID of the vehicle to be booked</small>
                    </div>
                </div>

                <div class="form-section">
                    <h4 class="form-section-title">Customer Information</h4>
                    <div class="form-group">
                        <label for="contactPersonName">Customer Name <span class="required">*</span></label>
                        <input type="text" class="form-control" id="contactPersonName" name="contactPersonName" required>
                    </div>

                    <div class="form-group">
                        <label for="bookedEmail">Email Address <span class="required">*</span></label>
                        <input type="email" class="form-control" id="bookedEmail" name="bookedEmail" required>
                    </div>

                    <div class="form-group">
                        <label for="contactNumber">Contact Number <span class="required">*</span></label>
                        <input type="tel" class="form-control" id="contactNumber" name="contactNumber" required>
                    </div>
                </div>

                <div class="form-section">
                    <h4 class="form-section-title">Booking Details</h4>
                    <div class="form-group">
                        <label for="bookingDate">Booking Date & Time <span class="required">*</span></label>
                        <input type="datetime-local" class="form-control" id="bookingDate" name="bookingDate" required>
                    </div>

                    <div class="form-group">
                        <label for="additionalNotes">Additional Notes</label>
                        <textarea class="form-control" id="additionalNotes" name="additionalNotes" rows="4" placeholder="Any special requirements or notes..."></textarea>
                    </div>
                </div>
            </div>

            <div class="form-actions">
                <a href="<c:url value='/bookings'/>" class="btn btn-secondary">
                    <i class="fas fa-times"></i> Cancel
                </a>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Create Booking
                </button>
            </div>
        </form>
    </div>
</div>

<%@ include file="../footer.jsp" %>

<script>
    // Set minimum date to today
    document.addEventListener('DOMContentLoaded', function() {
        const bookingDateInput = document.getElementById('bookingDate');
        if (bookingDateInput) {
            bookingDateInput.min = new Date().toISOString().slice(0, 16);
        }
    });
</script>
