<%-- Removed duplicate page directive - contentType is provided by header.jsp --%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicle Details - DriveGo Admin</title>
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
                    <a href="/vehicles" class="menu-item active">
                        <i class="fas fa-car"></i> Vehicles
                    </a>
                    <a href="/bookings" class="menu-item">
                        <i class="fas fa-calendar-check"></i> Bookings
                    </a>
                    <a href="/payments" class="menu-item">
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
                        <h1><i class="fas fa-eye"></i> Vehicle Details #${vehicle.id}</h1>
                        <div>
                            <a href="/vehicles/${vehicle.id}/edit" class="btn btn-warning me-2">
                                <i class="fas fa-edit"></i> Edit
                            </a>
                            <a href="/vehicles" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Back to Vehicles
                            </a>
                        </div>
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
                    <!-- Vehicle Information -->
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h5><i class="fas fa-car"></i> Vehicle Information</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <c:if test="${not empty vehicle.imageUrl}">
                                            <img src="${vehicle.imageUrl}" class="img-fluid rounded mb-3" alt="${vehicle.displayName}">
                                        </c:if>
                                        <c:if test="${empty vehicle.imageUrl}">
                                            <div class="bg-light rounded d-flex align-items-center justify-content-center mb-3" style="height: 200px;">
                                                <i class="fas fa-car fa-5x text-muted"></i>
                                            </div>
                                        </c:if>
                                    </div>
                                    <div class="col-md-6">
                                        <table class="table table-borderless">
                                            <tr>
                                                <td><strong>Make:</strong></td>
                                                <td>${vehicle.make}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Model:</strong></td>
                                                <td>${vehicle.model}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Year:</strong></td>
                                                <td>${vehicle.year}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Color:</strong></td>
                                                <td>${vehicle.color}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>License Plate:</strong></td>
                                                <td><code>${vehicle.licensePlate}</code></td>
                                            </tr>
                                            <tr>
                                                <td><strong>Status:</strong></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${vehicle.status == 'AVAILABLE'}">
                                                            <span class="badge bg-success fs-6">Available</span>
                                                        </c:when>
                                                        <c:when test="${vehicle.status == 'BOOKED'}">
                                                            <span class="badge bg-warning fs-6">Booked</span>
                                                        </c:when>
                                                        <c:when test="${vehicle.status == 'MAINTENANCE'}">
                                                            <span class="badge bg-danger fs-6">Maintenance</span>
                                                        </c:when>
                                                        <c:when test="${vehicle.status == 'RETIRED'}">
                                                            <span class="badge bg-secondary fs-6">Retired</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-secondary fs-6">${vehicle.status}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>

                                <hr>

                                <div class="row">
                                    <div class="col-md-6">
                                        <h6><i class="fas fa-cog"></i> Specifications</h6>
                                        <table class="table table-borderless">
                                            <tr>
                                                <td><strong>Type:</strong></td>
                                                <td><span class="badge bg-info">${vehicle.vehicleType}</span></td>
                                            </tr>
                                            <tr>
                                                <td><strong>Transmission:</strong></td>
                                                <td><span class="badge bg-secondary">${vehicle.transmission}</span></td>
                                            </tr>
                                            <tr>
                                                <td><strong>Fuel Type:</strong></td>
                                                <td><span class="badge bg-success">${vehicle.fuelType}</span></td>
                                            </tr>
                                            <tr>
                                                <td><strong>Seats:</strong></td>
                                                <td>${vehicle.seats}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Mileage:</strong></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty vehicle.mileage}">
                                                            <fmt:formatNumber value="${vehicle.mileage}" type="number"/> km
                                                        </c:when>
                                                        <c:otherwise>
                                                            Not specified
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="col-md-6">
                                        <h6><i class="fas fa-dollar-sign"></i> Pricing & Dates</h6>
                                        <table class="table table-borderless">
                                            <tr>
                                                <td><strong>Daily Rate:</strong></td>
                                                <td>
                                                    <h4 class="text-success mb-0">
                                                        LKR <fmt:formatNumber value="${vehicle.dailyRate}" type="number" minFractionDigits="2"/>
                                                    </h4>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><strong>Created:</strong></td>
                                                <td><fmt:formatDate value="${vehicle.createdAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                                            </tr>
                                            <tr>
                                                <td><strong>Last Updated:</strong></td>
                                                <td><fmt:formatDate value="${vehicle.updatedAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>

                                <c:if test="${not empty vehicle.description}">
                                    <hr>
                                    <h6><i class="fas fa-info-circle"></i> Description</h6>
                                    <div class="border p-3 bg-light rounded">
                                        ${vehicle.description}
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
                                    <a href="/vehicles/${vehicle.id}/edit" class="btn btn-warning">
                                        <i class="fas fa-edit"></i> Edit Vehicle
                                    </a>

                                    <hr>

                                    <h6>Status Management</h6>
                                    <c:if test="${vehicle.status != 'AVAILABLE'}">
                                        <button class="btn btn-success btn-sm" onclick="updateStatus('AVAILABLE')">
                                            <i class="fas fa-check"></i> Mark Available
                                        </button>
                                    </c:if>

                                    <c:if test="${vehicle.status != 'BOOKED'}">
                                        <button class="btn btn-warning btn-sm" onclick="updateStatus('BOOKED')">
                                            <i class="fas fa-calendar"></i> Mark Booked
                                        </button>
                                    </c:if>

                                    <c:if test="${vehicle.status != 'MAINTENANCE'}">
                                        <button class="btn btn-danger btn-sm" onclick="updateStatus('MAINTENANCE')">
                                            <i class="fas fa-wrench"></i> Mark Maintenance
                                        </button>
                                    </c:if>

                                    <c:if test="${vehicle.status != 'RETIRED'}">
                                        <button class="btn btn-secondary btn-sm" onclick="updateStatus('RETIRED')">
                                            <i class="fas fa-archive"></i> Retire Vehicle
                                        </button>
                                    </c:if>

                                    <hr>

                                    <a href="/bookings?carId=${vehicle.id}" class="btn btn-outline-primary">
                                        <i class="fas fa-calendar-check"></i> View Bookings
                                    </a>
                                    <a href="/bookings/new?carId=${vehicle.id}" class="btn btn-outline-success">
                                        <i class="fas fa-plus"></i> Create Booking
                                    </a>

                                    <hr>

                                    <button class="btn btn-outline-danger" onclick="deleteVehicle()">
                                        <i class="fas fa-trash"></i> Delete Vehicle
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
            if (confirm('Are you sure you want to update the vehicle status to ' + status + '?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '/vehicles/${vehicle.id}/status';

                const statusInput = document.createElement('input');
                statusInput.type = 'hidden';
                statusInput.name = 'status';
                statusInput.value = status;

                form.appendChild(statusInput);
                document.body.appendChild(form);
                form.submit();
            }
        }

        function deleteVehicle() {
            if (confirm('Are you sure you want to delete this vehicle? This action cannot be undone.')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '/vehicles/${vehicle.id}/delete';

                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>

