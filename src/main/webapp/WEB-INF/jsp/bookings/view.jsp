<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../admin-header.jsp" %>

<style>
    .booking-detail-container {
        padding: 2rem;
        background: #f8fafb;
        min-height: calc(100vh - 4rem);
    }
    
    .content-header {
        background: linear-gradient(135deg, #ffffff 0%, #f0fdf4 100%);
        padding: 2rem;
        border-radius: 1rem;
        margin-bottom: 2rem;
        border: 2px solid #16a34a;
        box-shadow: 0 4px 20px rgba(22, 163, 74, 0.1);
    }
    
    .content-header h1 {
        color: #15803d;
        font-size: 2rem;
        font-weight: 700;
        margin: 0;
        display: flex;
        align-items: center;
        gap: 1rem;
    }
    
    .card {
        border: none;
        border-radius: 1rem;
        box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
        margin-bottom: 1.5rem;
        background: #ffffff;
    }
    
    .card-header {
        background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%);
        border-bottom: 2px solid #16a34a;
        border-radius: 1rem 1rem 0 0 !important;
        padding: 1.25rem;
    }
    
    .card-header h5 {
        color: #15803d;
        font-weight: 600;
        margin: 0;
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }
    
    .btn-secondary {
        background: #6b7280;
        border: none;
        padding: 0.625rem 1.5rem;
        border-radius: 0.5rem;
        font-weight: 500;
        transition: all 0.3s;
    }
    
    .btn-secondary:hover {
        background: #4b5563;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(107, 114, 128, 0.3);
    }
</style>

<div class="booking-detail-container">
    <div class="content-header">
        <div class="d-flex justify-content-between align-items-center">
            <h1><i class="fas fa-eye"></i> Booking Details #${booking.id}</h1>
            <a href="/bookings" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Back to Bookings
            </a>
        </div>
    </div>

    <!-- Flash Messages -->
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="row">
        <!-- Booking Information -->
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <h5><i class="fas fa-info-circle"></i> Booking Information</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <table class="table table-borderless">
                                <tr>
                                    <td><strong>Booking ID:</strong></td>
                                    <td>#${booking.id}</td>
                                </tr>
                                <tr>
                                    <td><strong>Customer Name:</strong></td>
                                    <td>${booking.contactPersonName}</td>
                                </tr>
                                <tr>
                                    <td><strong>Email:</strong></td>
                                    <td>${booking.bookedEmail}</td>
                                </tr>
                                <tr>
                                    <td><strong>Contact Number:</strong></td>
                                    <td>${booking.contactNumber}</td>
                                </tr>
                                <tr>
                                    <td><strong>Vehicle Reg No:</strong></td>
                                    <td><span class="badge bg-info">${booking.vehicleRegNo}</span></td>
                                </tr>
                                <tr>
                                    <td><strong>Car ID:</strong></td>
                                    <td>#${booking.carId}</td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-md-6">
                                        <table class="table table-borderless">
                                            <tr>
                                                <td><strong>Pickup Date:</strong></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty booking.pickupDate}">
                                                            <fmt:formatDate value="${booking.pickupDate}" pattern="MMM dd, yyyy"/>
                                                        </c:when>
                                                        <c:otherwise>-</c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><strong>Return Date:</strong></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty booking.returnDate}">
                                                            <fmt:formatDate value="${booking.returnDate}" pattern="MMM dd, yyyy"/>
                                                        </c:when>
                                                        <c:otherwise>-</c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><strong>Pickup Location:</strong></td>
                                                <td>${not empty booking.pickupLocation ? booking.pickupLocation : '-'}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Booking Date:</strong></td>
                                                <td><fmt:formatDate value="${booking.bookingDate}" pattern="MMM dd, yyyy HH:mm"/></td>
                                            </tr>
                                            <tr>
                                                <td><strong>Status:</strong></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${booking.status == 'PENDING'}">
                                                            <span class="badge bg-warning fs-6">Pending</span>
                                                        </c:when>
                                                        <c:when test="${booking.status == 'CONFIRMED'}">
                                                            <span class="badge bg-success fs-6">Confirmed</span>
                                                        </c:when>
                                                        <c:when test="${booking.status == 'COMPLETED'}">
                                                            <span class="badge bg-primary fs-6">Completed</span>
                                                        </c:when>
                                                        <c:when test="${booking.status == 'CANCELLED'}">
                                                            <span class="badge bg-danger fs-6">Cancelled</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-secondary fs-6">${booking.status}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><strong>Created:</strong></td>
                                                <td><fmt:formatDate value="${booking.createdAt}" pattern="MMM dd, yyyy HH:mm"/></td>
                                            </tr>
                                            <tr>
                                                <td><strong>Last Updated:</strong></td>
                                                <td><fmt:formatDate value="${booking.updatedAt}" pattern="MMM dd, yyyy HH:mm"/></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>

                                <c:if test="${not empty booking.additionalNotes}">
                                    <div class="mt-3">
                                        <strong>Additional Notes:</strong>
                                        <div class="border p-3 mt-2 bg-light rounded">
                                            ${booking.additionalNotes}
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <!-- Actions -->
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                <h5><i class="fas fa-cogs"></i> Actions</h5>
                            </div>
                            <div class="card-body">
                                <div class="d-grid gap-2">
                                    <c:if test="${booking.status == 'PENDING'}">
                                        <button class="btn btn-success" onclick="updateStatus('CONFIRMED')">
                                            <i class="fas fa-check"></i> Confirm Booking
                                        </button>
                                        <button class="btn btn-danger" onclick="updateStatus('CANCELLED')">
                                            <i class="fas fa-times"></i> Cancel Booking
                                        </button>
                                    </c:if>

                                    <c:if test="${booking.status == 'CONFIRMED'}">
                                        <button class="btn btn-primary" onclick="updateStatus('COMPLETED')">
                                            <i class="fas fa-flag-checkered"></i> Mark Completed
                                        </button>
                                        <button class="btn btn-warning" onclick="updateStatus('PENDING')">
                                            <i class="fas fa-clock"></i> Mark Pending
                                        </button>
                                        <button class="btn btn-danger" onclick="updateStatus('CANCELLED')">
                                            <i class="fas fa-times"></i> Cancel Booking
                                        </button>
                                    </c:if>

                                    <c:if test="${booking.status == 'COMPLETED'}">
                                        <button class="btn btn-warning" onclick="updateStatus('CONFIRMED')">
                                            <i class="fas fa-undo"></i> Mark Confirmed
                                        </button>
                                    </c:if>

                                    <c:if test="${booking.status == 'CANCELLED'}">
                                        <button class="btn btn-success" onclick="updateStatus('CONFIRMED')">
                                            <i class="fas fa-redo"></i> Reactivate Booking
                                        </button>
                                    </c:if>

                                    <hr>
                                    <a href="/payments/new?bookingId=${booking.id}" class="btn btn-outline-success">
                                        <i class="fas fa-credit-card"></i> Create Payment
                                    </a>
                                    <a href="/payments?bookingId=${booking.id}" class="btn btn-outline-info">
                                        <i class="fas fa-list"></i> View Payments
                                    </a>
                                    <hr>
                                    <button class="btn btn-danger" onclick="deleteBooking()">
                                        <i class="fas fa-trash"></i> Delete Booking
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
</div>

<%@ include file="../admin-footer.jsp" %>

<script>
    function updateStatus(status) {
        if (confirm('Are you sure you want to update the booking status to ' + status + '?')) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '/bookings/${booking.id}/status';

            const statusInput = document.createElement('input');
            statusInput.type = 'hidden';
            statusInput.name = 'status';
            statusInput.value = status;
            
            // Add CSRF token
            const csrfInput = document.createElement('input');
            csrfInput.type = 'hidden';
            csrfInput.name = '${_csrf.parameterName}';
            csrfInput.value = '${_csrf.token}';

            form.appendChild(statusInput);
            form.appendChild(csrfInput);
            document.body.appendChild(form);
            form.submit();
        }
    }

    function deleteBooking() {
        if (confirm('Are you sure you want to delete this booking? This action cannot be undone.')) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '/bookings/${booking.id}/delete';
            
            // Add CSRF token
            const csrfInput = document.createElement('input');
            csrfInput.type = 'hidden';
            csrfInput.name = '${_csrf.parameterName}';
            csrfInput.value = '${_csrf.token}';
            form.appendChild(csrfInput);
            
            document.body.appendChild(form);
            form.submit();
        }
    }
</script>
