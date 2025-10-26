<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../admin-header.jsp" %>

<style>
    /* Edit Booking Page - Clean White Theme */
    .edit-container {
        padding: 2rem;
        background: #f8fafb;
        min-height: calc(100vh - 4rem);
    }

    .edit-header {
        background: linear-gradient(135deg, #ffffff 0%, #f0fdf4 100%);
        padding: 2rem;
        border-radius: 1rem;
        margin-bottom: 2rem;
        border: 2px solid #16a34a;
        box-shadow: 0 4px 20px rgba(22, 163, 74, 0.1);
    }

    .edit-header h1 {
        color: #15803d;
        font-size: 2rem;
        font-weight: 700;
        margin: 0 0 0.5rem 0;
        display: flex;
        align-items: center;
        gap: 1rem;
    }

    .edit-header h1 i {
        color: #16a34a;
    }

    .edit-header p {
        color: #64748b;
        font-size: 1rem;
        margin: 0;
    }

    .edit-card {
        background: #ffffff;
        border-radius: 1rem;
        padding: 2rem;
        border: 1px solid #e2e8f0;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
    }

    .form-section {
        margin-bottom: 2rem;
    }

    .form-section-title {
        color: #15803d;
        font-size: 1.25rem;
        font-weight: 700;
        margin-bottom: 1.5rem;
        padding-bottom: 0.75rem;
        border-bottom: 2px solid #dcfce7;
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }

    .form-section-title i {
        color: #16a34a;
    }

    .form-row {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 1.5rem;
        margin-bottom: 1.5rem;
    }

    .form-group {
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
    }

    .form-group label {
        color: #475569;
        font-size: 0.875rem;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .form-group label i {
        color: #16a34a;
        font-size: 1rem;
    }

    .form-group input,
    .form-group select,
    .form-group textarea {
        background: #ffffff;
        border: 1px solid #cbd5e1;
        color: #1e293b;
        padding: 0.75rem 1rem;
        border-radius: 0.5rem;
        font-size: 0.875rem;
        transition: all 0.3s ease;
    }

    .form-group input:focus,
    .form-group select:focus,
    .form-group textarea:focus {
        outline: none;
        border-color: #16a34a;
        box-shadow: 0 0 0 3px rgba(22, 163, 74, 0.1);
    }

    .form-group textarea {
        resize: vertical;
        min-height: 100px;
    }

    .status-selector {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
        gap: 1rem;
    }

    .status-option {
        position: relative;
    }

    .status-option input[type="radio"] {
        position: absolute;
        opacity: 0;
    }

    .status-option label {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        padding: 1rem;
        border: 2px solid #e2e8f0;
        border-radius: 0.75rem;
        cursor: pointer;
        transition: all 0.3s ease;
        text-align: center;
        gap: 0.5rem;
    }

    .status-option label i {
        font-size: 2rem;
        margin-bottom: 0.5rem;
    }

    .status-option label span {
        font-size: 0.875rem;
        font-weight: 600;
    }

    .status-option input[type="radio"]:checked + label {
        border-width: 3px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }

    .status-pending label {
        background: #fef3c7;
        color: #d97706;
        border-color: #fbbf24;
    }

    .status-pending input[type="radio"]:checked + label {
        border-color: #d97706;
        background: #fef3c7;
    }

    .status-confirmed label {
        background: #d1fae5;
        color: #059669;
        border-color: #10b981;
    }

    .status-confirmed input[type="radio"]:checked + label {
        border-color: #059669;
        background: #d1fae5;
    }

    .status-completed label {
        background: #dbeafe;
        color: #2563eb;
        border-color: #3b82f6;
    }

    .status-completed input[type="radio"]:checked + label {
        border-color: #2563eb;
        background: #dbeafe;
    }

    .status-cancelled label {
        background: #fee2e2;
        color: #dc2626;
        border-color: #ef4444;
    }

    .status-cancelled input[type="radio"]:checked + label {
        border-color: #dc2626;
        background: #fee2e2;
    }

    .form-actions {
        display: flex;
        gap: 1rem;
        justify-content: flex-end;
        padding-top: 2rem;
        border-top: 1px solid #e2e8f0;
    }

    .btn {
        padding: 0.75rem 2rem;
        border-radius: 0.5rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        border: none;
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        font-size: 0.875rem;
        text-decoration: none;
    }

    .btn-save {
        background: linear-gradient(135deg, #16a34a 0%, #15803d 100%);
        color: #fff;
        box-shadow: 0 2px 8px rgba(22, 163, 74, 0.3);
    }

    .btn-save:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(22, 163, 74, 0.4);
    }

    .btn-cancel {
        background: #e2e8f0;
        color: #475569;
    }

    .btn-cancel:hover {
        background: #cbd5e1;
        text-decoration: none;
    }

    .alert {
        padding: 1rem 1.25rem;
        border-radius: 0.5rem;
        margin-bottom: 1.5rem;
        display: flex;
        align-items: center;
        gap: 0.75rem;
        font-weight: 600;
        font-size: 0.875rem;
    }

    .alert-success {
        background: #d1fae5;
        color: #059669;
        border: 1px solid #10b981;
    }

    .alert-error {
        background: #fee2e2;
        color: #dc2626;
        border: 1px solid #ef4444;
    }
</style>

<div class="edit-container">
    <!-- Page Header -->
    <div class="edit-header">
        <h1><i class="fas fa-edit"></i> Edit Booking #${booking.id}</h1>
        <p>Update booking information and manage status</p>
    </div>

    <!-- Alerts -->
    <c:if test="${not empty success}">
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i>
            ${success}
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-error">
            <i class="fas fa-exclamation-circle"></i>
            ${error}
        </div>
    </c:if>

    <!-- Edit Form -->
    <form action="<c:url value='/bookings/${booking.id}/update'/>" method="post" class="edit-card">
        <!-- CSRF Token for Spring Security -->
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        
        <!-- Customer Information -->
        <div class="form-section">
            <h3 class="form-section-title">
                <i class="fas fa-user"></i>
                Customer Information
            </h3>
            <div class="form-row">
                <div class="form-group">
                    <label>
                        <i class="fas fa-user"></i>
                        Contact Person Name
                    </label>
                    <input type="text" name="contactPersonName" value="${booking.contactPersonName}" required>
                </div>
                <div class="form-group">
                    <label>
                        <i class="fas fa-envelope"></i>
                        Email Address
                    </label>
                    <input type="email" name="bookedEmail" value="${booking.bookedEmail}" required>
                </div>
                <div class="form-group">
                    <label>
                        <i class="fas fa-phone"></i>
                        Contact Number
                    </label>
                    <input type="text" name="contactNumber" value="${booking.contactNumber}" required>
                </div>
            </div>
        </div>

        <!-- Vehicle Information -->
        <div class="form-section">
            <h3 class="form-section-title">
                <i class="fas fa-car"></i>
                Vehicle Information
            </h3>
            <div class="form-row">
                <div class="form-group">
                    <label>
                        <i class="fas fa-hashtag"></i>
                        Vehicle Registration Number
                    </label>
                    <input type="text" name="vehicleRegNo" value="${booking.vehicleRegNo}" required>
                </div>
                <div class="form-group">
                    <label>
                        <i class="fas fa-map-marker-alt"></i>
                        Pickup Location
                    </label>
                    <input type="text" name="pickupLocation" value="${booking.pickupLocation}" required>
                </div>
            </div>
        </div>

        <!-- Booking Dates -->
        <div class="form-section">
            <h3 class="form-section-title">
                <i class="fas fa-calendar"></i>
                Booking Dates
            </h3>
            <div class="form-row">
                <div class="form-group">
                    <label>
                        <i class="fas fa-calendar-day"></i>
                        Pickup Date
                    </label>
                    <input type="date" name="pickupDate" 
                           value="<fmt:formatDate value='${booking.pickupDate}' pattern='yyyy-MM-dd'/>" required>
                </div>
                <div class="form-group">
                    <label>
                        <i class="fas fa-calendar-check"></i>
                        Return Date
                    </label>
                    <input type="date" name="returnDate" 
                           value="<fmt:formatDate value='${booking.returnDate}' pattern='yyyy-MM-dd'/>" required>
                </div>
            </div>
        </div>

        <!-- Booking Status -->
        <div class="form-section">
            <h3 class="form-section-title">
                <i class="fas fa-flag"></i>
                Booking Status
            </h3>
            <div class="status-selector">
                <div class="status-option status-pending">
                    <input type="radio" id="status-pending" name="status" value="PENDING" 
                           ${booking.status == 'PENDING' ? 'checked' : ''}>
                    <label for="status-pending">
                        <i class="fas fa-clock"></i>
                        <span>Pending</span>
                    </label>
                </div>
                <div class="status-option status-confirmed">
                    <input type="radio" id="status-confirmed" name="status" value="CONFIRMED" 
                           ${booking.status == 'CONFIRMED' ? 'checked' : ''}>
                    <label for="status-confirmed">
                        <i class="fas fa-check"></i>
                        <span>Confirmed</span>
                    </label>
                </div>
                <div class="status-option status-completed">
                    <input type="radio" id="status-completed" name="status" value="COMPLETED" 
                           ${booking.status == 'COMPLETED' ? 'checked' : ''}>
                    <label for="status-completed">
                        <i class="fas fa-flag-checkered"></i>
                        <span>Completed</span>
                    </label>
                </div>
                <div class="status-option status-cancelled">
                    <input type="radio" id="status-cancelled" name="status" value="CANCELLED" 
                           ${booking.status == 'CANCELLED' ? 'checked' : ''}>
                    <label for="status-cancelled">
                        <i class="fas fa-times"></i>
                        <span>Cancelled</span>
                    </label>
                </div>
            </div>
        </div>

        <!-- Additional Notes -->
        <div class="form-section">
            <h3 class="form-section-title">
                <i class="fas fa-sticky-note"></i>
                Additional Notes
            </h3>
            <div class="form-group">
                <textarea name="additionalNotes" placeholder="Enter any additional notes or special requests...">${booking.additionalNotes}</textarea>
            </div>
        </div>

        <!-- Form Actions -->
        <div class="form-actions">
            <a href="<c:url value='/bookings/${booking.id}'/>" class="btn btn-cancel">
                <i class="fas fa-times"></i>
                Cancel
            </a>
            <button type="submit" class="btn btn-save">
                <i class="fas fa-save"></i>
                Save Changes
            </button>
        </div>
    </form>
</div>

<%@ include file="../admin-footer.jsp" %>
