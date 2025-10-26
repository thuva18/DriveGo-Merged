<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../admin-header.jsp" %>

<style>
    /* Booking Management - Clean White Theme with Green Accents */
    .booking-container {
        padding: 2rem;
        background: #f8fafb;
        min-height: calc(100vh - 4rem);
    }

    .booking-page-header {
        background: linear-gradient(135deg, #ffffff 0%, #f0fdf4 100%);
        padding: 2rem;
        border-radius: 1rem;
        margin-bottom: 2rem;
        border: 2px solid #16a34a;
        box-shadow: 0 4px 20px rgba(22, 163, 74, 0.1);
    }

    .booking-page-header h1 {
        color: #15803d;
        font-size: 2rem;
        font-weight: 700;
        margin: 0 0 0.5rem 0;
        display: flex;
        align-items: center;
        gap: 1rem;
    }

    .booking-page-header h1 i {
        font-size: 2.25rem;
        color: #16a34a;
    }

    .booking-page-header p {
        color: #64748b;
        font-size: 1rem;
        margin: 0;
    }

    .booking-page-header .header-actions {
        margin-top: 1.5rem;
    }

    /* Filters Section */
    .booking-filters {
        background: #ffffff;
        padding: 1.5rem;
        border-radius: 1rem;
        margin-bottom: 2rem;
        border: 1px solid #e2e8f0;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    }

    .booking-filters h3 {
        color: #1e293b;
        font-size: 1.125rem;
        margin: 0 0 1.25rem 0;
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }

    .booking-filters h3 i {
        color: #16a34a;
    }

    .filter-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 1.25rem;
        align-items: end;
    }

    .filter-group {
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
    }

    .filter-group label {
        color: #475569;
        font-size: 0.875rem;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .filter-group input,
    .filter-group select {
        background: #ffffff;
        border: 1px solid #cbd5e1;
        color: #1e293b;
        padding: 0.75rem 1rem;
        border-radius: 0.5rem;
        font-size: 0.875rem;
        transition: all 0.3s ease;
    }

    .filter-group input:focus,
    .filter-group select:focus {
        outline: none;
        border-color: #16a34a;
        box-shadow: 0 0 0 3px rgba(22, 163, 74, 0.1);
    }

    .filter-actions {
        display: flex;
        gap: 0.75rem;
        align-items: flex-end;
    }

    .btn-filter-search {
        background: linear-gradient(135deg, #16a34a 0%, #15803d 100%);
        color: #fff;
        border: none;
        padding: 0.75rem 1.5rem;
        border-radius: 0.5rem;
        font-weight: 600;
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        transition: all 0.3s ease;
        box-shadow: 0 2px 8px rgba(22, 163, 74, 0.3);
    }

    .btn-filter-search:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(22, 163, 74, 0.4);
    }

    .btn-filter-clear {
        background: #e2e8f0;
        color: #475569;
        border: none;
        padding: 0.75rem 1.5rem;
        border-radius: 0.5rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
    }

    .btn-filter-clear:hover {
        background: #cbd5e1;
        text-decoration: none;
    }

    .btn-new-booking {
        background: linear-gradient(135deg, #16a34a 0%, #15803d 100%);
        color: #fff;
        border: none;
        padding: 0.75rem 1.5rem;
        border-radius: 0.5rem;
        font-weight: 600;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        transition: all 0.3s ease;
        box-shadow: 0 2px 8px rgba(22, 163, 74, 0.3);
    }

    .btn-new-booking:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(22, 163, 74, 0.4);
        text-decoration: none;
    }

    /* Results Toolbar */
    .booking-results-toolbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 1.5rem;
    }

    .booking-count {
        color: #64748b;
        font-size: 0.875rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .booking-count i {
        color: #16a34a;
    }

    .booking-count strong {
        color: #15803d;
        font-size: 1.125rem;
    }

    /* Table Section */
    .booking-table-card {
        background: #ffffff;
        border-radius: 1rem;
        overflow: hidden;
        border: 1px solid #e2e8f0;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
    }

    .booking-table-header {
        background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%);
        padding: 1.25rem 1.5rem;
        border-bottom: 2px solid #16a34a;
    }

    .booking-table-header h3 {
        color: #15803d;
        font-size: 1.125rem;
        margin: 0;
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }

    .booking-table-header h3 i {
        color: #16a34a;
    }

    .booking-table {
        width: 100%;
        border-collapse: collapse;
    }

    .booking-table thead {
        background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%);
    }

    .booking-table thead th {
        color: #15803d;
        text-align: left;
        padding: 1rem 1.25rem;
        font-size: 0.8125rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 1px;
        border-bottom: 2px solid #16a34a;
    }

    .booking-table tbody tr {
        border-bottom: 1px solid #e2e8f0;
        transition: all 0.3s ease;
    }

    .booking-table tbody tr:hover {
        background: #f0fdf4;
    }

    .booking-table tbody td {
        padding: 1.25rem;
        color: #1e293b;
        font-size: 0.875rem;
    }

    .booking-id {
        color: #16a34a;
        font-weight: 700;
        font-size: 1rem;
    }

    .customer-info {
        display: flex;
        flex-direction: column;
        gap: 0.25rem;
    }

    .customer-name {
        color: #1e293b;
        font-weight: 600;
    }

    .customer-email {
        color: #64748b;
        font-size: 0.75rem;
        text-decoration: none;
    }

    .customer-email:hover {
        color: #16a34a;
        text-decoration: underline;
    }

    .vehicle-badge {
        background: linear-gradient(135deg, #16a34a 0%, #15803d 100%);
        color: #fff;
        padding: 0.375rem 0.875rem;
        border-radius: 0.5rem;
        font-weight: 700;
        font-size: 0.8125rem;
        display: inline-block;
        box-shadow: 0 2px 8px rgba(22, 163, 74, 0.3);
    }

    .date-display {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        color: #64748b;
    }

    .date-display i {
        color: #16a34a;
    }

    /* Status Badges - Matching Vehicle Page Colors */
    .status-badge {
        padding: 0.5rem 1rem;
        border-radius: 1.25rem;
        font-weight: 700;
        font-size: 0.75rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
    }

    .status-pending {
        background: #fef3c7;
        color: #d97706;
        border: 1px solid #fbbf24;
    }

    .status-confirmed {
        background: #d1fae5;
        color: #059669;
        border: 1px solid #10b981;
    }

    .status-completed {
        background: #dbeafe;
        color: #2563eb;
        border: 1px solid #3b82f6;
    }

    .status-cancelled {
        background: #fee2e2;
        color: #dc2626;
        border: 1px solid #ef4444;
    }

    .action-btns {
        display: flex;
        gap: 0.5rem;
        align-items: center;
    }

    .btn-action {
        background: #e2e8f0;
        color: #475569;
        border: none;
        padding: 0.5rem 0.75rem;
        border-radius: 0.375rem;
        cursor: pointer;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        font-size: 0.875rem;
        text-decoration: none;
    }

    .btn-action:hover {
        background: #16a34a;
        color: #fff;
        transform: translateY(-2px);
    }

    .btn-action.btn-view {
        background: #dbeafe;
        color: #2563eb;
    }

    .btn-action.btn-view:hover {
        background: #3b82f6;
        color: #fff;
    }

    .btn-action.btn-edit {
        background: #d1fae5;
        color: #059669;
    }

    .btn-action.btn-edit:hover {
        background: #10b981;
        color: #fff;
    }

    .btn-action.btn-delete {
        background: #fee2e2;
        color: #dc2626;
    }

    .btn-action.btn-delete:hover {
        background: #ef4444;
        color: #fff;
    }

    .dropdown {
        position: relative;
    }

    .btn-dropdown {
        background: linear-gradient(135deg, #16a34a 0%, #15803d 100%);
        color: #fff;
        border: none;
        padding: 0.5rem 0.75rem;
        border-radius: 0.375rem;
        cursor: pointer;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        gap: 0.375rem;
        transition: all 0.3s ease;
        font-size: 0.875rem;
    }

    .btn-dropdown:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(22, 163, 74, 0.4);
    }

    .dropdown-content {
        display: none;
        position: absolute;
        top: 100%;
        right: 0;
        margin-top: 0.375rem;
        background: #ffffff;
        border: 1px solid #e2e8f0;
        border-radius: 0.5rem;
        min-width: 180px;
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
        z-index: 1000;
        overflow: hidden;
    }

    .dropdown-content.show {
        display: block;
    }

    .dropdown-item {
        color: #1e293b;
        padding: 0.75rem 1rem;
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 0.75rem;
        transition: all 0.3s ease;
        font-size: 0.875rem;
        border-bottom: 1px solid #e2e8f0;
    }

    .dropdown-item:last-child {
        border-bottom: none;
    }

    .dropdown-item:hover {
        background: #f0fdf4;
        color: #15803d;
        text-decoration: none;
    }

    /* Alerts */
    .booking-alert {
        padding: 1rem 1.25rem;
        border-radius: 0.5rem;
        margin-bottom: 1.5rem;
        display: flex;
        align-items: center;
        gap: 0.75rem;
        font-weight: 600;
        font-size: 0.875rem;
    }

    .booking-alert-success {
        background: #d1fae5;
        color: #059669;
        border: 1px solid #10b981;
    }

    .booking-alert-error {
        background: #fee2e2;
        color: #dc2626;
        border: 1px solid #ef4444;
    }

    /* Pagination */
    .booking-pagination {
        padding: 1.5rem;
        background: #ffffff;
        border-top: 1px solid #e2e8f0;
        display: flex;
        justify-content: center;
        gap: 0.5rem;
    }

    .page-btn {
        background: #ffffff;
        color: #475569;
        padding: 0.625rem 1rem;
        border-radius: 0.375rem;
        text-decoration: none;
        border: 1px solid #cbd5e1;
        transition: all 0.3s ease;
        font-weight: 600;
        font-size: 0.875rem;
    }

    .page-btn:hover {
        background: #f0fdf4;
        border-color: #16a34a;
        color: #15803d;
        text-decoration: none;
    }

    .page-btn.active {
        background: #16a34a;
        color: #fff;
        border-color: #16a34a;
    }

    /* Empty State */
    .empty-state {
        text-align: center;
        padding: 4rem 2rem;
        color: #64748b;
    }

    .empty-state i {
        font-size: 4rem;
        margin-bottom: 1.5rem;
        opacity: 0.3;
        color: #16a34a;
    }

    .empty-state h3 {
        color: #1e293b;
        margin-bottom: 0.75rem;
        font-size: 1.5rem;
    }

    .empty-state p {
        color: #64748b;
        font-size: 1rem;
    }
</style>

<div class="booking-container">
    <!-- Page Header -->
    <div class="booking-page-header">
        <h1><i class="fas fa-calendar-check"></i> Booking Management</h1>
        <p>Manage and monitor all vehicle bookings efficiently</p>
        <div class="header-actions">
            <a href="<c:url value='/bookings/new'/>" class="btn-new-booking">
                <i class="fas fa-plus"></i>
                New Booking
            </a>
        </div>
    </div>


    <!-- Flash Messages -->
    <c:if test="${not empty success}">
        <div class="booking-alert booking-alert-success">
            <i class="fas fa-check-circle"></i>
            ${success}
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="booking-alert booking-alert-error">
            <i class="fas fa-exclamation-triangle"></i>
            ${error}
        </div>
    </c:if>

    <!-- Filters Section -->
    <div class="booking-filters">
        <h3><i class="fas fa-filter"></i> Search & Filter Bookings</h3>
        <form method="GET" action="/bookings">
            <div class="filter-grid">
                <div class="filter-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" placeholder="customer@example.com" value="${param.email}">
                </div>
                <div class="filter-group">
                    <label for="contactName">Contact Name</label>
                    <input type="text" id="contactName" name="contactName" placeholder="Customer name" value="${param.contactName}">
                </div>
                <div class="filter-group">
                    <label for="status">Status</label>
                    <select id="status" name="status">
                        <option value="">All Statuses</option>
                        <option value="PENDING" ${param.status == 'PENDING' ? 'selected' : ''}>Pending</option>
                        <option value="CONFIRMED" ${param.status == 'CONFIRMED' ? 'selected' : ''}>Confirmed</option>
                        <option value="COMPLETED" ${param.status == 'COMPLETED' ? 'selected' : ''}>Completed</option>
                        <option value="CANCELLED" ${param.status == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                    </select>
                </div>
                <div class="filter-actions">
                    <button type="submit" class="btn-filter-search">
                        <i class="fas fa-search"></i> Search
                    </button>
                    <a href="/bookings" class="btn-filter-clear">
                        <i class="fas fa-times"></i> Clear
                    </a>
                </div>
            </div>
        </form>
    </div>

    <!-- Results Toolbar -->
    <div class="booking-results-toolbar">
        <div class="booking-count">
            <i class="fas fa-calendar-check"></i>
            <strong>${totalElements}</strong> bookings found
        </div>
    </div>

    <!-- Bookings Table -->
    <c:choose>
        <c:when test="${empty bookings}">
            <div class="booking-table-card">
                <div class="empty-state">
                    <i class="fas fa-calendar-times"></i>
                    <h3>No Bookings Found</h3>
                    <p>There are no bookings matching your criteria.</p>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="booking-table-card">
                <div class="booking-table-header">
                    <h3><i class="fas fa-list"></i> Booking Records</h3>
                </div>
                <table class="booking-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Customer</th>
                            <th>Contact</th>
                            <th>Vehicle</th>
                            <th>Pickup Date</th>
                            <th>Return Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="booking" items="${bookings}">
                            <tr>
                                <td>
                                    <span class="booking-id">#${booking.id}</span>
                                </td>
                                <td>
                                    <div class="customer-info">
                                        <span class="customer-name">${booking.contactPersonName}</span>
                                        <a href="mailto:${booking.bookedEmail}" class="customer-email">${booking.bookedEmail}</a>
                                    </div>
                                </td>
                                <td>
                                    <a href="tel:${booking.contactNumber}" style="color: #16a34a; text-decoration: none; display: flex; align-items: center; gap: 0.5rem;">
                                        <i class="fas fa-phone"></i> ${booking.contactNumber}
                                    </a>
                                </td>
                                <td>
                                    <span class="vehicle-badge">${booking.vehicleRegNo}</span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty booking.pickupDate}">
                                            <div class="date-display">
                                                <i class="fas fa-calendar-day"></i>
                                                <fmt:formatDate value="${booking.pickupDate}" pattern="MMM dd, yyyy"/>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: #64748b;">-</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty booking.returnDate}">
                                            <div class="date-display">
                                                <i class="fas fa-calendar-check"></i>
                                                <fmt:formatDate value="${booking.returnDate}" pattern="MMM dd, yyyy"/>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: #64748b;">-</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${booking.status == 'PENDING'}">
                                            <span class="status-badge status-pending">
                                                <i class="fas fa-clock"></i> Pending
                                            </span>
                                        </c:when>
                                        <c:when test="${booking.status == 'CONFIRMED'}">
                                            <span class="status-badge status-confirmed">
                                                <i class="fas fa-check"></i> Confirmed
                                            </span>
                                        </c:when>
                                        <c:when test="${booking.status == 'COMPLETED'}">
                                            <span class="status-badge status-completed">
                                                <i class="fas fa-flag-checkered"></i> Completed
                                            </span>
                                        </c:when>
                                        <c:when test="${booking.status == 'CANCELLED'}">
                                            <span class="status-badge status-cancelled">
                                                <i class="fas fa-times"></i> Cancelled
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge">${booking.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="action-btns">
                                        <a href="<c:url value='/bookings/${booking.id}'/>" class="btn-action btn-view" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <a href="<c:url value='/bookings/${booking.id}/edit'/>" class="btn-action btn-edit" title="Edit Booking">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <button class="btn-action btn-delete" onclick="deleteBooking(${booking.id})" title="Delete Booking">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Pagination -->
        <c:if test="${totalPages > 1}">
            <div class="booking-pagination">
                <c:if test="${currentPage > 0}">
                    <a href="?page=${currentPage - 1}&size=10" class="page-btn">
                        <i class="fas fa-chevron-left"></i>
                    </a>
                </c:if>

                <c:forEach begin="0" end="${totalPages - 1}" var="page">
                    <c:choose>
                        <c:when test="${page == currentPage}">
                            <span class="page-btn active">${page + 1}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="?page=${page}&size=10" class="page-btn">${page + 1}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:if test="${currentPage < totalPages - 1}">
                    <a href="?page=${currentPage + 1}&size=10" class="page-btn">
                        <i class="fas fa-chevron-right"></i>
                    </a>
                </c:if>
            </div>
        </c:if>
    </c:otherwise>
</c:choose>

<%@ include file="../admin-footer.jsp" %>

<script>
    // Handle booking deletion
    function deleteBooking(bookingId) {
        if (confirm('Are you sure you want to delete this booking? This action cannot be undone.')) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '/bookings/' + bookingId + '/delete';
            
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

