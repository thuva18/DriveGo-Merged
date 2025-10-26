<%-- Removed duplicate page directive - contentType is provided by header.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Payment - DriveGo Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="/css/style.css" rel="stylesheet">
</head>
<body>
    <%@ include file="../admin-header.jsp" %>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-2 sidebar">
                <div class="sidebar-menu">
                    <a href="/dashboard" class="menu-item">
                        <i class="fas fa-tachometer-alt"></i> Dashboard
                    </a>
                    <a href="/vehicles" class="menu-item">
                        <i class="fas fa-car"></i> Vehicles
                    </a>
                    <a href="/bookings" class="menu-item">
                        <i class="fas fa-calendar-check"></i> Bookings
                    </a>
                    <a href="/payments" class="menu-item active">
                        <i class="fas fa-credit-card"></i> Payments
                    </a>
                    <a href="/reports" class="menu-item">
                        <i class="fas fa-chart-bar"></i> Reports
                    </a>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-md-10 main-content">
                <div class="content-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h1><i class="fas fa-plus"></i> Process New Payment</h1>
                        <a href="/payments" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Back to Payments
                        </a>
                    </div>
                </div>

                <!-- Flash Messages -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <div class="card">
                    <div class="card-body">
                        <form method="POST" action="/payments">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="bookingId" class="form-label">Booking ID <span class="text-danger">*</span></label>
                                        <input type="number" class="form-control" id="bookingId" name="bookingId"
                                               value="${param.bookingId}" required>
                                        <div class="form-text">Enter the booking ID for this payment</div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="amount" class="form-label">Amount <span class="text-danger">*</span></label>
                                        <div class="input-group">
                                            <span class="input-group-text">$</span>
                                            <input type="number" step="0.01" min="0" class="form-control" id="amount" name="amount" required>
                                        </div>
                                        <div class="form-text">Enter the payment amount</div>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="paymentMethod" class="form-label">Payment Method <span class="text-danger">*</span></label>
                                        <select class="form-select" id="paymentMethod" name="paymentMethod" required>
                                            <option value="">Select Payment Method</option>
                                            <option value="CASH">Cash</option>
                                            <option value="CREDIT_CARD">Credit Card</option>
                                            <option value="DEBIT_CARD">Debit Card</option>
                                            <option value="BANK_TRANSFER">Bank Transfer</option>
                                            <option value="ONLINE">Online Payment</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-12">
                                    <div class="alert alert-info">
                                        <i class="fas fa-info-circle"></i>
                                        <strong>Note:</strong> Payment will be created with PENDING status. You can update the status after processing.
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-12">
                                    <div class="d-flex justify-content-end gap-2">
                                        <a href="/payments" class="btn btn-secondary">Cancel</a>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-credit-card"></i> Process Payment
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="../admin-footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
