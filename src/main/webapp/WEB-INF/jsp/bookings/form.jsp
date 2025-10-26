<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../admin-header.jsp" %>

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
        <h3><i class="fas fa-plus"></i> New Booking Details</h3>
    </div>
    <div class="card-body">
        <form method="POST" action="<c:url value='/bookings'/>" class="form-grid">
            <!-- CSRF Token for Spring Security -->
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            
            <div class="form-section">
                <h4 class="form-section-title">Vehicle Information</h4>
                <div class="form-group">
                    <label for="carId">Vehicle ID <span class="required">*</span></label>
                    <input type="number" class="form-control" id="carId" name="carId" required 
                           placeholder="Enter vehicle ID">
                    <small class="form-help">Enter the ID of the vehicle to be booked</small>
                </div>
            </div>

            <div class="form-section">
                <h4 class="form-section-title">Customer Details</h4>
                <div class="form-group">
                    <label for="contactPersonName">Customer Name <span class="required">*</span></label>
                    <input type="text" class="form-control" id="contactPersonName" name="contactPersonName" required 
                           placeholder="Full name of the customer">
                </div>
                
                <div class="form-group">
                    <label for="bookedEmail">Email Address <span class="required">*</span></label>
                    <input type="email" class="form-control" id="bookedEmail" name="bookedEmail" required 
                           placeholder="customer@example.com">
                </div>
                
                <div class="form-group">
                    <label for="contactNumber">Contact Number <span class="required">*</span></label>
                    <input type="tel" class="form-control" id="contactNumber" name="contactNumber" required 
                           placeholder="+1 (555) 123-4567">
                </div>
            </div>

            <div class="form-section">
                <h4 class="form-section-title">Booking Information</h4>
                <div class="form-group">
                    <label for="bookingDate">Booking Date & Time <span class="required">*</span></label>
                    <input type="datetime-local" class="form-control" id="bookingDate" name="bookingDate" required>
                    <small class="form-help">Select the date and time for the booking</small>
                </div>
                
                <div class="form-group">
                    <label for="additionalNotes">Additional Notes</label>
                    <textarea class="form-control" id="additionalNotes" name="additionalNotes" rows="4" 
                              placeholder="Any special requirements, pickup location, or additional information..."></textarea>
                </div>
            </div>

            <div class="form-actions">
                <a href="<c:url value='/bookings'/>" class="btn btn-secondary">
                    <i class="fas fa-times"></i> Cancel
                </a>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-calendar-plus"></i> Create Booking
                </button>
            </div>
        </form>
    </div>
</div>

<%@ include file="../admin-footer.jsp" %>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Set minimum date to today
        const bookingDateInput = document.getElementById('bookingDate');
        if (bookingDateInput) {
            const now = new Date();
            const year = now.getFullYear();
            const month = String(now.getMonth() + 1).padStart(2, '0');
            const day = String(now.getDate()).padStart(2, '0');
            const hours = String(now.getHours()).padStart(2, '0');
            const minutes = String(now.getMinutes()).padStart(2, '0');
            
            bookingDateInput.min = `${year}-${month}-${day}T${hours}:${minutes}`;
        }
        
        // Form validation
        const form = document.querySelector('form');
        form.addEventListener('submit', function(e) {
            const carId = document.getElementById('carId').value;
            const customerName = document.getElementById('contactPersonName').value;
            const email = document.getElementById('bookedEmail').value;
            const contact = document.getElementById('contactNumber').value;
            const bookingDate = document.getElementById('bookingDate').value;
            
            if (!carId || !customerName || !email || !contact || !bookingDate) {
                e.preventDefault();
                alert('Please fill in all required fields.');
                return false;
            }
        });
    });
</script>