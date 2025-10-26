<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../admin-header.jsp" %>

<div class="page-header">
    <div>
        <h1 class="page-title">Vehicle Management</h1>
        <p class="page-subtitle">Manage your fleet inventory</p>
    </div>
    <div class="page-actions">
        <a href="<c:url value='/vehicles/new'/>" class="btn btn-primary">
            <i class="fas fa-plus"></i>
            Add Vehicle
        </a>
    </div>
</div>

<!-- Flash Messages -->
<c:if test="${not empty param.success}">
    <div class="alert alert-success">
        <i class="fas fa-check-circle"></i>
        <span>Vehicle ${param.success} successfully!</span>
    </div>
</c:if>

<c:if test="${not empty error}">
    <div class="alert alert-danger">
        <i class="fas fa-exclamation-triangle"></i>
        <span>${error}</span>
    </div>
</c:if>

<!-- Enhanced Filters Section -->
<div class="filters-section-enhanced">
    <div class="filters-header">
        <h3 class="filters-title">
            <i class="fas fa-filter"></i> Filter Vehicles
        </h3>
    </div>
    <form method="GET" action="/vehicles" class="filter-form-enhanced">
        <div class="form-group-enhanced">
            <label for="search">Search</label>
            <input type="text" id="search" name="search" class="form-control-enhanced" 
                   placeholder="Search by model or reg no..." value="${param.search}">
        </div>
        <div class="form-group-enhanced">
            <label for="fuelType">Fuel Type</label>
            <select id="fuelType" name="fuelType" class="form-control-enhanced">
                <option value="">All Fuel Types</option>
                <option value="Petrol" ${param.fuelType == 'Petrol' ? 'selected' : ''}>Petrol</option>
                <option value="Diesel" ${param.fuelType == 'Diesel' ? 'selected' : ''}>Diesel</option>
                <option value="Electric" ${param.fuelType == 'Electric' ? 'selected' : ''}>Electric</option>
                <option value="Hybrid" ${param.fuelType == 'Hybrid' ? 'selected' : ''}>Hybrid</option>
            </select>
        </div>
        <div class="form-group-enhanced">
            <label for="minPrice">Min Price (LKR/day)</label>
            <input type="number" id="minPrice" name="minPrice" class="form-control-enhanced" 
                   placeholder="Min price" min="0" step="0.01" value="${param.minPrice}">
        </div>
        <div class="form-group-enhanced">
            <label for="maxPrice">Max Price (LKR/day)</label>
            <input type="number" id="maxPrice" name="maxPrice" class="form-control-enhanced" 
                   placeholder="Max price" min="0" step="0.01" value="${param.maxPrice}">
        </div>
        <div class="form-group-enhanced">
            <label for="availability">Availability</label>
            <select id="availability" name="availability" class="form-control-enhanced">
                <option value="">All Status</option>
                <option value="true" ${param.availability == 'true' ? 'selected' : ''}>Available</option>
                <option value="false" ${param.availability == 'false' ? 'selected' : ''}>Not Available</option>
            </select>
        </div>
        <div class="form-group-enhanced form-actions">
            <button type="submit" class="btn btn-search">
                <i class="fas fa-search"></i> Search
            </button>
            <a href="/vehicles" class="btn btn-clear">
                <i class="fas fa-times"></i> Clear
            </a>
        </div>
    </form>
</div>

<!-- View Toggle and Results Count -->
<div class="results-toolbar">
    <div class="results-count">
        <i class="fas fa-car"></i>
        <strong>${vehicles.size()}</strong> vehicles found
    </div>
    <div class="view-toggle">
        <button class="view-btn active" data-view="grid" onclick="toggleView('grid')">
            <i class="fas fa-th"></i> Grid
        </button>
        <button class="view-btn" data-view="list" onclick="toggleView('list')">
            <i class="fas fa-list"></i> List
        </button>
    </div>
</div>

<!-- Vehicles Grid -->
<c:choose>
    <c:when test="${empty vehicles}">
        <div class="card empty-state">
            <i class="fas fa-car fa-4x"></i>
            <h3>No Vehicles Found</h3>
            <p>Start by adding your first vehicle to the fleet or adjust your search filters.</p>
            <a href="<c:url value='/vehicles/new'/>" class="btn btn-primary" style="margin-top: 20px;">
                <i class="fas fa-plus"></i> Add Vehicle
            </a>
        </div>
    </c:when>
    <c:otherwise>
        <div class="vehicles-container" id="vehiclesContainer">
            <c:forEach var="vehicle" items="${vehicles}">
                <div class="vehicle-card-enhanced">
                    <div class="vehicle-card-image-enhanced">
                        <c:choose>
                            <c:when test="${not empty vehicle.image}">
                                <img src="<c:url value='/uploads/vehicles/${vehicle.image}'/>" alt="${vehicle.model}" class="vehicle-image-actual" />
                            </c:when>
                            <c:when test="${not empty vehicle.imageUrl}">
                                <img src="${vehicle.imageUrl}" alt="${vehicle.model}" class="vehicle-image-actual" />
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-car"></i>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${vehicle.availability}">
                                <span class="availability-badge available">
                                    <i class="fas fa-check-circle"></i> Available
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="availability-badge unavailable">
                                    <i class="fas fa-times-circle"></i> Unavailable
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="vehicle-card-body">
                        <h3 class="vehicle-card-title">${vehicle.model}</h3>
                        <div class="vehicle-card-reg">
                            <i class="fas fa-id-card"></i> ${vehicle.regNo}
                        </div>
                        
                        <div class="vehicle-card-info">
                            <div class="info-item-enhanced">
                                <i class="fas fa-gas-pump"></i>
                                <span>${vehicle.fuelType}</span>
                            </div>
                            <div class="info-item-enhanced">
                                <i class="fas fa-tachometer-alt"></i>
                                <span>${vehicle.mileage} km</span>
                            </div>
                            <div class="info-item-enhanced">
                                <i class="fas fa-dollar-sign"></i>
                                <span class="price-highlight">LKR ${vehicle.rentalPrice}/day</span>
                            </div>
                        </div>
                    </div>
                    <div class="vehicle-card-footer">
                        <a href="<c:url value='/vehicles/edit/${vehicle.regNo}'/>" class="btn btn-edit">
                            <i class="fas fa-edit"></i> Edit
                        </a>
                        <button onclick="confirmDelete('${vehicle.regNo}', '${vehicle.model}')" class="btn btn-delete">
                            <i class="fas fa-trash"></i> Delete
                        </button>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

<style>
    /* Enhanced Filter Section with Modern Green Gradient Theme */
    .filters-section-enhanced {
        background: linear-gradient(135deg, #ffffff 0%, #f0fdf4 100%);
        border-radius: var(--radius-xl);
        padding: 1.5rem;
        margin-bottom: 1.5rem;
        box-shadow: 0 8px 32px rgba(22, 163, 74, 0.1);
        border: 1px solid rgba(22, 163, 74, 0.1);
        transition: all 0.3s ease;
    }

    .filters-section-enhanced:hover {
        box-shadow: 0 12px 48px rgba(22, 163, 74, 0.15);
        transform: translateY(-2px);
    }

    .filters-header {
        margin-bottom: 1.5rem;
    }

    .filters-title {
        font-size: 1.25rem;
        font-weight: var(--font-weight-semibold);
        background: linear-gradient(135deg, #16a34a 0%, #059669 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .filters-title i {
        background: linear-gradient(135deg, #16a34a 0%, #059669 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        font-size: 1.5rem;
        animation: pulse 2s ease-in-out infinite;
    }

    @keyframes pulse {
        0%, 100% { opacity: 1; }
        50% { opacity: 0.7; }
    }

    .filter-form-enhanced {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 1rem;
        align-items: end;
    }

    .form-group-enhanced {
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
        position: relative;
    }

    .form-group-enhanced label {
        font-weight: var(--font-weight-medium);
        color: #059669;
        font-size: 0.875rem;
        transition: all 0.3s ease;
    }

    .form-control-enhanced {
        padding: 0.7rem 1rem;
        border: 2px solid #d1fae5;
        border-radius: var(--radius-md);
        font-size: 0.9375rem;
        transition: all 0.3s ease;
        background: white;
    }

    .form-control-enhanced:focus {
        outline: none;
        border-color: #16a34a;
        box-shadow: 0 0 0 4px rgba(22, 163, 74, 0.1);
        transform: translateY(-2px);
    }

    .form-control-enhanced:hover {
        border-color: #10b981;
    }

    .form-actions {
        display: flex;
        gap: 0.5rem;
    }

    .btn-search {
        flex: 1;
        background: linear-gradient(135deg, #16a34a 0%, #059669 100%);
        color: white;
        border: none;
        padding: 0.7rem 1.5rem;
        border-radius: var(--radius-md);
        font-weight: var(--font-weight-medium);
        cursor: pointer;
        transition: all 0.3s ease;
        box-shadow: 0 4px 12px rgba(22, 163, 74, 0.3);
        position: relative;
        overflow: hidden;
    }

    .btn-search::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
        transition: left 0.5s;
    }

    .btn-search:hover::before {
        left: 100%;
    }

    .btn-search:hover {
        transform: translateY(-3px);
        box-shadow: 0 6px 20px rgba(22, 163, 74, 0.4);
    }

    .btn-search:active {
        transform: translateY(-1px);
    }

    .btn-clear {
        background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
        color: #0284c7;
        border: 2px solid #bae6fd;
        padding: 0.7rem 1.5rem;
        border-radius: var(--radius-md);
        font-weight: var(--font-weight-medium);
        cursor: pointer;
        transition: all 0.3s ease;
        text-decoration: none;
        display: inline-block;
    }

    .btn-clear:hover {
        background: linear-gradient(135deg, #e0f2fe 0%, #bae6fd 100%);
        color: #0369a1;
        border-color: #0284c7;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(2, 132, 199, 0.2);
    }

    /* Results Toolbar */
    .results-toolbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background: linear-gradient(135deg, #ffffff 0%, #f0fdf4 100%);
        padding: 1rem 1.5rem;
        border-radius: var(--radius-lg);
        margin-bottom: 1.5rem;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
        border: 2px solid #d1fae5;
        transition: all 0.3s ease;
    }

    .results-toolbar:hover {
        box-shadow: 0 6px 20px rgba(16, 185, 129, 0.15);
    }

    .results-count {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        font-size: 1rem;
        color: var(--text-secondary);
    }

    .results-count i {
        color: #059669;
        font-size: 1.25rem;
        transition: all 0.3s ease;
    }

    .results-toolbar:hover .results-count i {
        transform: scale(1.1);
        color: #10b981;
    }

    .results-count strong {
        color: #059669;
        font-weight: var(--font-weight-bold);
        font-size: 1.125rem;
    }

    .view-toggle {
        display: flex;
        gap: 0.5rem;
        background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
        padding: 0.35rem;
        border-radius: var(--radius-md);
        border: 1px solid #bae6fd;
    }

    .view-btn {
        padding: 0.5rem 1rem;
        border: none;
        background: transparent;
        color: #64748b;
        cursor: pointer;
        border-radius: var(--radius-sm);
        font-weight: var(--font-weight-medium);
        font-size: 0.875rem;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        display: flex;
        align-items: center;
        gap: 0.4rem;
    }

    .view-btn:hover {
        color: #0284c7;
        background: rgba(255, 255, 255, 0.5);
        transform: translateY(-1px);
    }

    .view-btn.active {
        background: linear-gradient(135deg, #16a34a 0%, #059669 100%);
        color: white;
        box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
        transform: translateY(-2px);
    }

    /* Vehicles Container */
    .vehicles-container {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
        gap: 1.5rem;
        transition: all 0.3s;
    }

    .vehicles-container.list-view {
        grid-template-columns: 1fr;
    }

    /* Enhanced Vehicle Cards with Green Theme */
    .vehicle-card-enhanced {
        background: linear-gradient(145deg, #ffffff 0%, #f0fdf4 100%);
        border: 2px solid #d1fae5;
        border-radius: var(--radius-xl);
        overflow: hidden;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        display: flex;
        flex-direction: column;
        position: relative;
    }

    .vehicle-card-enhanced::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 4px;
        background: linear-gradient(90deg, #10b981 0%, #3b82f6 50%, #10b981 100%);
        background-size: 200% 100%;
        animation: shimmer 3s linear infinite;
        opacity: 0;
        transition: opacity 0.4s;
    }

    @keyframes shimmer {
        0% { background-position: -200% 0; }
        100% { background-position: 200% 0; }
    }

    .vehicle-card-enhanced:hover::before {
        opacity: 1;
    }

    .vehicle-card-enhanced:hover {
        transform: translateY(-8px) scale(1.02);
        box-shadow: 0 20px 40px rgba(16, 185, 129, 0.2), 0 10px 20px rgba(59, 130, 246, 0.1);
        border-color: #10b981;
    }

    .vehicles-container.list-view .vehicle-card-enhanced {
        flex-direction: row;
    }

    .vehicles-container.list-view .vehicle-card-enhanced:hover {
        transform: translateX(8px) scale(1.01);
    }

    .vehicle-card-image-enhanced {
        width: 100%;
        height: 200px;
        background: linear-gradient(135deg, #10b981 0%, #059669 50%, #0284c7 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 3.5rem;
        position: relative;
        transition: all 0.4s ease;
        overflow: hidden;
    }

    .vehicle-image-actual {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: all 0.4s ease;
    }

    .vehicle-card-enhanced:hover .vehicle-image-actual {
        transform: scale(1.05);
    }

    .vehicle-card-enhanced:hover .vehicle-card-image-enhanced {
        background: linear-gradient(135deg, #059669 0%, #10b981 50%, #0369a1 100%);
    }

    .vehicles-container.list-view .vehicle-card-image-enhanced {
        width: 250px;
        height: auto;
        min-height: 200px;
    }

    .availability-badge {
        position: absolute;
        top: 1rem;
        right: 1rem;
        padding: 0.5rem 0.9rem;
        border-radius: var(--radius-lg);
        font-size: 0.75rem;
        font-weight: var(--font-weight-semibold);
        display: flex;
        align-items: center;
        gap: 0.4rem;
        backdrop-filter: blur(10px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        transition: all 0.3s ease;
    }

    .availability-badge:hover {
        transform: scale(1.05);
    }

    .availability-badge.available {
        background: linear-gradient(135deg, rgba(255, 255, 255, 0.98) 0%, rgba(220, 252, 231, 0.98) 100%);
        color: #047857;
        border: 1px solid #6ee7b7;
    }

    .availability-badge.unavailable {
        background: linear-gradient(135deg, rgba(255, 255, 255, 0.98) 0%, rgba(254, 226, 226, 0.98) 100%);
        color: #dc2626;
        border: 1px solid #fca5a5;
    }

    .vehicle-card-body {
        padding: 1.5rem;
        flex: 1;
    }

    .vehicle-card-title {
        font-size: 1.25rem;
        font-weight: var(--font-weight-bold);
        background: linear-gradient(135deg, #047857 0%, #0369a1 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        margin-bottom: 0.5rem;
        transition: all 0.3s ease;
    }

    .vehicle-card-enhanced:hover .vehicle-card-title {
        background: linear-gradient(135deg, #059669 0%, #0284c7 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }

    .vehicle-card-reg {
        color: var(--text-secondary);
        font-size: 0.875rem;
        margin-bottom: 1rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .vehicle-card-reg i {
        color: #059669;
        transition: all 0.3s ease;
    }

    .vehicle-card-enhanced:hover .vehicle-card-reg i {
        color: #10b981;
        transform: scale(1.1);
    }

    .vehicle-card-info {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 0.75rem;
        margin-top: 1rem;
    }

    .vehicles-container.list-view .vehicle-card-info {
        grid-template-columns: repeat(4, 1fr);
    }

    .info-item-enhanced {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        font-size: 0.875rem;
        color: var(--text-secondary);
        padding: 0.4rem 0.7rem;
        background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
        border-radius: var(--radius-sm);
        border: 1px solid #bae6fd;
        transition: all 0.3s ease;
    }

    .info-item-enhanced:hover {
        transform: translateY(-2px);
        background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%);
        box-shadow: 0 4px 8px rgba(59, 130, 246, 0.15);
    }

    .info-item-enhanced i {
        color: #0284c7;
        font-size: 1rem;
    }

    .price-highlight {
        color: #059669;
        font-weight: var(--font-weight-bold);
        font-size: 1rem;
    }

    .vehicle-card-footer {
        padding: 1rem 1.5rem;
        background: linear-gradient(135deg, #f9fafb 0%, #f3f4f6 100%);
        border-top: 2px solid #e5e7eb;
        display: flex;
        gap: 0.75rem;
    }

    .btn-edit {
        flex: 1;
        padding: 0.7rem 1rem;
        border: none;
        background: linear-gradient(135deg, #16a34a 0%, #059669 100%);
        color: white;
        border-radius: var(--radius-md);
        font-weight: var(--font-weight-medium);
        font-size: 0.875rem;
        cursor: pointer;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        text-decoration: none;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.4rem;
        box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
        position: relative;
        overflow: hidden;
    }

    .btn-edit::before {
        content: '';
        position: absolute;
        top: 50%;
        left: 50%;
        width: 0;
        height: 0;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.3);
        transform: translate(-50%, -50%);
        transition: width 0.5s, height 0.5s;
    }

    .btn-edit:hover::before {
        width: 300px;
        height: 300px;
    }

    .btn-edit:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 20px rgba(16, 185, 129, 0.4);
    }

    .btn-delete {
        flex: 1;
        padding: 0.7rem 1rem;
        border: none;
        background: linear-gradient(135deg, #ffffff 0%, #fef2f2 100%);
        color: #dc2626;
        border: 2px solid #fca5a5;
        border-radius: var(--radius-md);
        font-weight: var(--font-weight-medium);
        font-size: 0.875rem;
        cursor: pointer;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.4rem;
        box-shadow: 0 2px 8px rgba(239, 68, 68, 0.2);
    }

    .btn-delete:hover {
        background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
        color: white;
        border-color: #dc2626;
        transform: translateY(-3px);
        box-shadow: 0 8px 20px rgba(239, 68, 68, 0.4);
    }

    /* Empty State */
    .empty-state {
        text-align: center;
        padding: 4rem 2rem;
        background: white;
        border-radius: var(--radius-xl);
        box-shadow: var(--shadow-md);
    }

    .empty-state i {
        color: var(--accent-300);
        margin-bottom: 1.5rem;
    }

    .empty-state h3 {
        color: var(--text-primary);
        font-size: 1.5rem;
        margin-bottom: 0.5rem;
        font-weight: var(--font-weight-semibold);
    }

    .empty-state p {
        color: var(--text-secondary);
        margin-bottom: 1.5rem;
    }

    /* Responsive Design */
    @media (max-width: 768px) {
        .filter-form-enhanced {
            grid-template-columns: 1fr;
        }

        .results-toolbar {
            flex-direction: column;
            gap: 1rem;
        }

        .vehicles-container {
            grid-template-columns: 1fr;
        }

        .vehicles-container.list-view .vehicle-card-enhanced {
            flex-direction: column;
        }

        .vehicles-container.list-view .vehicle-card-image-enhanced {
            width: 100%;
            height: 200px;
        }

        .vehicles-container.list-view .vehicle-card-info {
            grid-template-columns: repeat(2, 1fr);
        }
    }
</style>

<script>
    function confirmDelete(regNo, model) {
        if (confirm('Are you sure you want to delete ' + model + ' (Reg: ' + regNo + ')?\n\nThis action cannot be undone.')) {
            window.location.href = '<c:url value="/vehicles/delete/"/>' + regNo;
        }
    }

    function toggleView(view) {
        const container = document.getElementById('vehiclesContainer');
        const gridBtn = document.querySelector('[data-view="grid"]');
        const listBtn = document.querySelector('[data-view="list"]');
        
        if (view === 'list') {
            container.classList.add('list-view');
            listBtn.classList.add('active');
            gridBtn.classList.remove('active');
            localStorage.setItem('vehicleView', 'list');
        } else {
            container.classList.remove('list-view');
            gridBtn.classList.add('active');
            listBtn.classList.remove('active');
            localStorage.setItem('vehicleView', 'grid');
        }
    }

    // Restore saved view preference on page load
    document.addEventListener('DOMContentLoaded', function() {
        const savedView = localStorage.getItem('vehicleView');
        if (savedView === 'list') {
            toggleView('list');
        }
    });
</script>

<%@ include file="../admin-footer.jsp" %>