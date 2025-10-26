<%-- Removed duplicate page directive - contentType is provided by header.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Details - DriveGo Admin</title>
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
                        <h1><i class="fas fa-eye"></i> Payment Details #${payment.id}</h1>
                        <a href="/payments" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Back to Payments
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
                    <!-- Payment Information -->
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h5><i class="fas fa-credit-card"></i> Payment Information</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <table class="table table-borderless">
                                            <tr>
                                                <td><strong>Payment ID:</strong></td>
                                                <td>#${payment.id}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Booking ID:</strong></td>
                                                <td>
                                                    <a href="/bookings/${payment.bookingId}" class="text-decoration-none">
                                                        #${payment.bookingId}
                                                    </a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><strong>Amount:</strong></td>
                                                <td>
                                                    <h4 class="text-success mb-0">
                                                        LKR <fmt:formatNumber value="${payment.amount}" type="number" minFractionDigits="2"/>
                                                    </h4>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><strong>Payment Method:</strong></td>
                                                <td><span class="badge bg-info fs-6">${payment.paymentMethod}</span></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="col-md-6">
                                        <table class="table table-borderless">
                                            <tr>
                                                <td><strong>Status:</strong></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${payment.paymentStatus == 'PENDING'}">
                                                            <span class="badge bg-warning fs-6">Pending</span>
                                                        </c:when>
                                                        <c:when test="${payment.paymentStatus == 'COMPLETED'}">
                                                            <span class="badge bg-success fs-6">Completed</span>
                                                        </c:when>
                                                        <c:when test="${payment.paymentStatus == 'FAILED'}">
                                                            <span class="badge bg-danger fs-6">Failed</span>
                                                        </c:when>
                                                        <c:when test="${payment.paymentStatus == 'REFUNDED'}">
                                                            <span class="badge bg-secondary fs-6">Refunded</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-secondary fs-6">${payment.paymentStatus}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><strong>Transaction ID:</strong></td>
                                                <td><code>${payment.transactionId}</code></td>
                                            </tr>
                                            <tr>
                                                <td><strong>Created:</strong></td>
                                                <td><fmt:formatDate value="${payment.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                            </tr>
                                            <tr>
                                                <td><strong>Last Updated:</strong></td>
                                                <td><fmt:formatDate value="${payment.updatedAt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
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
                                    <c:if test="${payment.paymentStatus == 'PENDING'}">
                                        <button class="btn btn-success" onclick="updateStatus('COMPLETED')">
                                            <i class="fas fa-check"></i> Mark Completed
                                        </button>
                                        <button class="btn btn-danger" onclick="updateStatus('FAILED')">
                                            <i class="fas fa-times"></i> Mark Failed
                                        </button>
                                    </c:if>

                                    <c:if test="${payment.paymentStatus == 'COMPLETED'}">
                                        <button class="btn btn-warning" onclick="updateStatus('REFUNDED')">
                                            <i class="fas fa-undo"></i> Process Refund
                                        </button>
                                        <button class="btn btn-secondary" onclick="updateStatus('PENDING')">
                                            <i class="fas fa-clock"></i> Mark Pending
                                        </button>
                                    </c:if>

                                    <c:if test="${payment.paymentStatus == 'FAILED'}">
                                        <button class="btn btn-success" onclick="updateStatus('COMPLETED')">
                                            <i class="fas fa-redo"></i> Mark Completed
                                        </button>
                                        <button class="btn btn-warning" onclick="updateStatus('PENDING')">
                                            <i class="fas fa-clock"></i> Mark Pending
                                        </button>
                                    </c:if>

                                    <c:if test="${payment.paymentStatus == 'REFUNDED'}">
                                        <button class="btn btn-success" onclick="updateStatus('COMPLETED')">
                                            <i class="fas fa-redo"></i> Restore Payment
                                        </button>
                                    </c:if>

                                    <hr>
                                    <a href="/bookings/${payment.bookingId}" class="btn btn-outline-primary">
                                        <i class="fas fa-calendar-check"></i> View Booking
                                    </a>
                                    <button class="btn btn-outline-secondary" onclick="window.print()">
                                        <i class="fas fa-print"></i> Print Receipt
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="../admin-footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function updateStatus(status) {
            if (confirm('Are you sure you want to update the payment status to ' + status + '?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '/payments/${payment.id}/status';

                const statusInput = document.createElement('input');
                statusInput.type = 'hidden';
                statusInput.name = 'status';
                statusInput.value = status;

                form.appendChild(statusInput);
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>
