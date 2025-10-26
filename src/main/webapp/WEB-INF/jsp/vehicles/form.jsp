<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../admin-header.jsp" %>

<div class="page-header">
    <div>
        <h1 class="page-title">${empty vehicle.regNo ? 'Add New Vehicle' : 'Edit Vehicle'}</h1>
        <p class="page-subtitle">${empty vehicle.regNo ? 'Add a new vehicle to your fleet' : 'Update vehicle information'}</p>
    </div>
    <div class="page-actions">
        <a href="<c:url value='/vehicles'/>" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i>
            Back to Vehicles
        </a>
    </div>
</div>

<!-- Flash Messages -->
<c:if test="${not empty error}">
    <div class="alert alert-danger">
        <i class="fas fa-exclamation-triangle"></i>
        <span>${error}</span>
    </div>
</c:if>

<!-- Vehicle Form -->
<div class="form-container">
    <form method="POST" action="<c:url value='/vehicles/save'/>" class="form" enctype="multipart/form-data">
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">
                    <i class="fas fa-info-circle"></i>
                    Basic Information
                </h2>
            </div>
            <div class="card-body">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="regNo" class="form-label">
                            Registration Number <span class="required">*</span>
                        </label>
                        <input 
                            type="text" 
                            id="regNo" 
                            name="regNo" 
                            class="form-control"
                            value="${vehicle.regNo}"
                            ${not empty vehicle.regNo ? 'readonly' : ''}
                            required
                            pattern="[A-Z]{2,3}[-\s]?\d{4}"
                            title="Enter registration number in format: ABC-1234 or ABC 1234"
                            placeholder="e.g., ABC-1234"
                            maxlength="10"
                        >
                        <c:if test="${empty vehicle.regNo}">
                            <small class="form-text">Registration number cannot be changed after creation</small>
                        </c:if>
                    </div>

                    <div class="form-group">
                        <label for="model" class="form-label">
                            Vehicle Model <span class="required">*</span>
                        </label>
                        <input 
                            type="text" 
                            id="model" 
                            name="model" 
                            class="form-control"
                            value="${vehicle.model}"
                            required
                            minlength="2"
                            maxlength="100"
                            pattern="[a-zA-Z0-9\s\-]+"
                            title="Vehicle model should contain only letters, numbers, spaces, and hyphens"
                            placeholder="e.g., Toyota Camry 2023"
                        >
                    </div>

                    <div class="form-group">
                        <label for="imageUrl" class="form-label">
                            Vehicle Image URL
                        </label>
                        <input 
                            type="url" 
                            id="imageUrl" 
                            name="imageUrl" 
                            class="form-control"
                            value="${vehicle.imageUrl}"
                            placeholder="https://example.com/car-image.jpg"
                        >
                        <small class="form-text">Enter the URL of the vehicle image (optional)</small>
                    </div>

                    <div class="form-group full-width">
                        <label for="imageFile" class="form-label">
                            Or Upload Vehicle Image
                        </label>
                        <div class="image-upload-container">
                            <input 
                                type="file" 
                                id="imageFile" 
                                name="imageFile" 
                                class="form-control"
                                accept="image/jpeg,image/jpg,image/png,image/gif"
                                onchange="previewImage(event)"
                                title="Please select a valid image file (JPG, PNG, GIF) up to 5MB"
                            >
                            <small class="form-text">Upload JPG, PNG, or GIF (Max 5MB)</small>
                            
                            <!-- Image Preview -->
                            <div id="imagePreview" class="image-preview" style="display: ${not empty vehicle.image ? 'block' : 'none'}">
                                <img id="previewImg" src="${not empty vehicle.image ? '/uploads/vehicles/' += vehicle.image : ''}" alt="Preview">
                                <p class="preview-label">Current Image</p>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="mileage" class="form-label">
                            Mileage (km)
                        </label>
                        <input 
                            type="number" 
                            id="mileage" 
                            name="mileage" 
                            class="form-control"
                            value="${vehicle.mileage}"
                            min="0"
                            placeholder="0"
                        >
                    </div>

                    <div class="form-group">
                        <label for="seats" class="form-label">
                            Number of Seats <span class="required">*</span>
                        </label>
                        <input 
                            type="number" 
                            id="seats" 
                            name="seats" 
                            class="form-control"
                            value="${vehicle.seats}"
                            min="1"
                            max="15"
                            required
                            placeholder="5"
                        >
                        <small class="form-text">Number of passenger seats</small>
                    </div>

                    <div class="form-group">
                        <label for="rentalPrice" class="form-label">
                            Rental Price (per day) <span class="required">*</span>
                        </label>
                        <input 
                            type="number" 
                            id="rentalPrice" 
                            name="rentalPrice" 
                            class="form-control"
                            value="${vehicle.rentalPrice}"
                            step="0.01"
                            min="0.01"
                            required
                            placeholder="0.00"
                        >
                        <small class="form-text">Enter price in LKR</small>
                    </div>

                    <div class="form-group">
                        <label for="dailyRate" class="form-label">
                            Daily Rate <span class="required">*</span>
                        </label>
                        <input 
                            type="number" 
                            id="dailyRate" 
                            name="dailyRate" 
                            class="form-control"
                            value="${vehicle.dailyRate}"
                            step="0.01"
                            min="0.01"
                            required
                            placeholder="0.00"
                        >
                        <small class="form-text">Usually same as rental price (LKR)</small>
                    </div>
                </div>
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <h2 class="card-title">
                    <i class="fas fa-cog"></i>
                    Vehicle Specifications
                </h2>
            </div>
            <div class="card-body">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="fuelType" class="form-label">
                            Fuel Type <span class="required">*</span>
                        </label>
                        <div class="select">
                            <select id="fuelType" name="fuelType" required>
                                <option value="">-- Select Fuel Type --</option>
                                <option value="Petrol" ${vehicle.fuelType == 'Petrol' ? 'selected' : ''}>Petrol</option>
                                <option value="Diesel" ${vehicle.fuelType == 'Diesel' ? 'selected' : ''}>Diesel</option>
                                <option value="Electric" ${vehicle.fuelType == 'Electric' ? 'selected' : ''}>Electric</option>
                                <option value="Hybrid" ${vehicle.fuelType == 'Hybrid' ? 'selected' : ''}>Hybrid</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="availability" class="form-label">
                            Availability Status
                        </label>
                        <div class="select">
                            <select id="availability" name="availability">
                                <option value="true" ${vehicle.availability == true ? 'selected' : ''}>Available for Rent</option>
                                <option value="false" ${vehicle.availability == false ? 'selected' : ''}>Not Available</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group full-width">
                        <label for="maintenanceHistory" class="form-label">
                            Maintenance History
                        </label>
                        <textarea 
                            id="maintenanceHistory" 
                            name="maintenanceHistory" 
                            class="form-control"
                            rows="4"
                            placeholder="Enter maintenance records, service dates, and any relevant information..."
                        >${vehicle.maintenanceHistory}</textarea>
                        <small class="form-text">Optional: Track service history and maintenance records</small>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-actions">
            <a href="<c:url value='/vehicles'/>" class="btn btn-secondary">
                <i class="fas fa-times"></i> Cancel
            </a>
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-save"></i> ${empty vehicle.regNo ? 'Add Vehicle' : 'Update Vehicle'}
            </button>
        </div>
    </form>
</div>

<style>
    .form-container {
        max-width: 900px;
    }
    
    .form-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 1.5rem;
    }
    
    .form-group.full-width {
        grid-column: 1 / -1;
    }
    
    .form-actions {
        display: flex;
        gap: 1rem;
        justify-content: flex-end;
        margin-top: 2rem;
    }
    
    .required {
        color: var(--danger);
    }
    
    .form-text {
        display: block;
        margin-top: 0.25rem;
        font-size: 0.875rem;
        color: var(--text-tertiary);
    }
    
    input[readonly] {
        background-color: var(--gray-100);
        cursor: not-allowed;
    }
    
    /* Image Upload Styles */
    .image-upload-container {
        display: flex;
        flex-direction: column;
        gap: 1rem;
    }
    
    .image-preview {
        margin-top: 1rem;
        padding: 1rem;
        border: 2px dashed #d1fae5;
        border-radius: var(--radius-lg);
        background: linear-gradient(135deg, #f0fdf4 0%, #ffffff 100%);
        text-align: center;
    }
    
    .image-preview img {
        max-width: 100%;
        max-height: 300px;
        border-radius: var(--radius-md);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        object-fit: contain;
    }
    
    .preview-label {
        margin-top: 0.5rem;
        font-size: 0.875rem;
        color: #059669;
        font-weight: 500;
    }
</style>

<script>
    function previewImage(event) {
        const file = event.target.files[0];
        const preview = document.getElementById('imagePreview');
        const previewImg = document.getElementById('previewImg');
        
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                previewImg.src = e.target.result;
                preview.style.display = 'block';
            }
            reader.readAsDataURL(file);
        } else {
            preview.style.display = 'none';
        }
    }
    
    // Auto-sync dailyRate with rentalPrice
    document.addEventListener('DOMContentLoaded', function() {
        const rentalPriceInput = document.getElementById('rentalPrice');
        const dailyRateInput = document.getElementById('dailyRate');
        
        if (rentalPriceInput && dailyRateInput) {
            rentalPriceInput.addEventListener('input', function() {
                if (this.value) {
                    dailyRateInput.value = this.value;
                }
            });
        }
    });
</script>

<%@ include file="../admin-footer.jsp" %>


