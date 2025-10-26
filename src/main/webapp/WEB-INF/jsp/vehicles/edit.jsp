<%-- Removed duplicate page directive - contentType is provided by header.jsp --%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Vehicle - DriveGo Admin</title>
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
                        <h1><i class="fas fa-edit"></i> Edit Vehicle #${vehicle.id}</h1>
                        <a href="/vehicles/${vehicle.id}" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Back to Vehicle
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
                        <form method="POST" action="/vehicles/save" enctype="multipart/form-data">
                            <input type="hidden" name="regNo" value="${vehicle.regNo}">
                            <div class="row">
                                <div class="col-md-6">
                                    <h5 class="mb-3">Basic Information</h5>

                                    <div class="mb-3">
                                        <label for="model" class="form-label">Model <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="model" name="model" value="${vehicle.model}" required>
                                        <div class="form-text">e.g., Toyota Corolla 2023</div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="regNo" class="form-label">Registration Number (License Plate)</label>
                                        <input type="text" class="form-control" id="regNo" value="${vehicle.regNo}" readonly disabled>
                                        <div class="form-text">Registration number cannot be changed</div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="seats" class="form-label">Seats <span class="text-danger">*</span></label>
                                                <input type="number" min="1" max="15" class="form-control" id="seats" name="seats" value="${vehicle.seats}" required>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="mileage" class="form-label">Mileage (km) <span class="text-danger">*</span></label>
                                                <input type="number" min="0" class="form-control" id="mileage" name="mileage" value="${vehicle.mileage}" required>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="imageFile" class="form-label">Vehicle Image</label>
                                        <input type="file" class="form-control" id="imageFile" name="imageFile" accept="image/*">
                                        <div class="form-text">Upload a new image or leave blank to keep current image</div>
                                        <c:if test="${not empty vehicle.image}">
                                            <div class="mt-2">
                                                <small class="text-muted">Current image: ${vehicle.image}</small>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <h5 class="mb-3">Pricing & Specifications</h5>

                                    <div class="mb-3">
                                        <label for="fuelType" class="form-label">Fuel Type <span class="text-danger">*</span></label>
                                        <select class="form-select" id="fuelType" name="fuelType" required>
                                            <option value="">Select Fuel Type</option>
                                            <option value="Petrol" ${vehicle.fuelType == 'Petrol' ? 'selected' : ''}>Petrol</option>
                                            <option value="Diesel" ${vehicle.fuelType == 'Diesel' ? 'selected' : ''}>Diesel</option>
                                            <option value="Electric" ${vehicle.fuelType == 'Electric' ? 'selected' : ''}>Electric</option>
                                            <option value="Hybrid" ${vehicle.fuelType == 'Hybrid' ? 'selected' : ''}>Hybrid</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="dailyRate" class="form-label">Daily Rate (LKR) <span class="text-danger">*</span></label>
                                        <input type="number" step="0.01" min="0" class="form-control" id="dailyRate" name="dailyRate" value="${vehicle.dailyRate}" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="rentalPrice" class="form-label">Rental Price (LKR) <span class="text-danger">*</span></label>
                                        <input type="number" step="0.01" min="0" class="form-control" id="rentalPrice" name="rentalPrice" value="${vehicle.rentalPrice}" required>
                                        <div class="form-text">Usually same as daily rate</div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="availability" class="form-label">Availability <span class="text-danger">*</span></label>
                                        <select class="form-select" id="availability" name="availability" required>
                                            <option value="">Select Availability</option>
                                            <option value="true" ${vehicle.availability == true ? 'selected' : ''}>Available</option>
                                            <option value="false" ${vehicle.availability == false ? 'selected' : ''}>Not Available</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="maintenanceHistory" class="form-label">Maintenance History</label>
                                        <textarea class="form-control" id="maintenanceHistory" name="maintenanceHistory" rows="4" placeholder="Last serviced: YYYY-MM-DD. Details...">${vehicle.maintenanceHistory}</textarea>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-12">
                                    <div class="d-flex justify-content-end gap-2">
                                        <a href="/vehicles/${vehicle.regNo}" class="btn btn-secondary">Cancel</a>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save"></i> Update Vehicle
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

