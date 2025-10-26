<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../admin-header.jsp" %>

<style>
    .payment-management-container {
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
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .content-header h1 {
        color: #15803d;
        font-size: 2rem;
        font-weight: 700;
        margin: 0;
    }
    
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 1.5rem;
        margin-bottom: 2rem;
    }
    
    .stat-card {
        background: #ffffff;
        border-radius: 1rem;
        padding: 1.5rem;
        box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
        border-left: 4px solid #16a34a;
    }
    
    .stat-card h3 {
        font-size: 0.875rem;
        color: #64748b;
        margin: 0 0 0.5rem 0;
        font-weight: 600;
    }
    
    .stat-value {
        font-size: 1.75rem;
        font-weight: 700;
        color: #15803d;
    }
    
    .filter-card {
        background: #ffffff;
        border-radius: 1rem;
        box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
        padding: 1.5rem;
        margin-bottom: 2rem;
    }
    
    .filter-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 1rem;
        align-items: end;
    }
    
    .form-group {
        margin-bottom: 0;
    }
    
    .form-label {
        font-weight: 600;
        color: #374151;
        margin-bottom: 0.5rem;
        display: block;
        font-size: 0.875rem;
    }
    
    .form-control, .form-select {
        width: 100%;
        padding: 0.75rem;
        border: 2px solid #e5e7eb;
        border-radius: 0.5rem;
        font-size: 1rem;
        transition: all 0.3s;
    }
    
    .form-control:focus, .form-select:focus {
        outline: none;
        border-color: #16a34a;
        box-shadow: 0 0 0 3px rgba(22, 163, 74, 0.1);
    }
    
    .table-card {
        background: #ffffff;
        border-radius: 1rem;
        box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
        overflow: hidden;
    }
    
    .table-header {
        padding: 1.5rem;
        border-bottom: 2px solid #f0fdf4;
    }
    
    .table-header h2 {
        margin: 0;
        color: #15803d;
        font-size: 1.25rem;
        font-weight: 700;
    }
    
    .table-responsive {
        overflow-x: auto;
    }
    
    table {
        width: 100%;
        border-collapse: collapse;
    }
    
    thead {
        background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%);
    }
    
    th {
        padding: 1rem;
        text-align: left;
        font-weight: 700;
        color: #15803d;
        font-size: 0.875rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    td {
        padding: 1rem;
        border-bottom: 1px solid #f1f5f9;
        color: #475569;
    }
    
    tbody tr:hover {
        background: #f8fafb;
    }
    
    .btn {
        padding: 0.75rem 1.5rem;
        border-radius: 0.5rem;
        font-weight: 600;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        border: none;
        cursor: pointer;
        transition: all 0.3s;
    }
    
    .btn-primary {
        background: #16a34a;
        color: white;
    }
    
    .btn-primary:hover {
        background: #15803d;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(22, 163, 74, 0.3);
    }
    
    .btn-secondary {
        background: #64748b;
        color: white;
    }
    
    .btn-secondary:hover {
        background: #475569;
    }
    
    .btn-sm {
        padding: 0.5rem 1rem;
        font-size: 0.875rem;
    }
    
    .badge {
        padding: 0.375rem 0.75rem;
        border-radius: 0.375rem;
        font-size: 0.75rem;
        font-weight: 600;
        display: inline-block;
    }
    
    .badge-success {
        background: #dcfce7;
        color: #166534;
    }
    
    .badge-warning {
        background: #fef3c7;
        color: #92400e;
    }
    
    .badge-danger {
        background: #fee2e2;
        color: #991b1b;
    }
    
    .badge-info {
        background: #dbeafe;
        color: #1e40af;
    }
    
    .badge-secondary {
        background: #f1f5f9;
        color: #475569;
    }
    
    .alert {
        padding: 1rem 1.5rem;
        border-radius: 0.5rem;
        margin-bottom: 1.5rem;
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }
    
    .alert-success {
        background: #dcfce7;
        color: #166534;
        border-left: 4px solid #16a34a;
    }
    
    .alert-danger {
        background: #fee2e2;
        color: #991b1b;
        border-left: 4px solid #dc2626;
    }
    
    .pagination {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 0.5rem;
        padding: 1.5rem;
    }
    
    .pagination a, .pagination span {
        padding: 0.5rem 1rem;
        border-radius: 0.375rem;
        text-decoration: none;
        color: #475569;
        border: 1px solid #e5e7eb;
    }
    
    .pagination a:hover {
        background: #f0fdf4;
        border-color: #16a34a;
        color: #15803d;
    }
    
    .pagination .active {
        background: #16a34a;
        color: white;
        border-color: #16a34a;
    }
    
    .action-buttons {
        display: flex;
        gap: 0.5rem;
    }
    
    .empty-state {
        text-align: center;
        padding: 3rem;
        color: #64748b;
    }
    
    .empty-state i {
        font-size: 3rem;
        margin-bottom: 1rem;
        color: #cbd5e1;
    }
</style>

<main class="main-content">
    <div class="payment-management-container">
        <div class="content-header">
            <div>
                <h1><i class="fas fa-credit-card"></i> Payment Management</h1>
                <p style="margin: 0.5rem 0 0 0; color: #64748b;">Manage and monitor all payment transactions</p>
            </div>
            <a href="<c:url value='/admin/payments/new'/>" class="btn btn-primary">
                <i class="fas fa-plus"></i> Record Payment
            </a>
        </div>

        <!-- Flash Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                ${success}
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i>
                ${error}
            </div>
        </c:if>

        <!-- Stats Grid -->
        <div class="stats-grid">
            <div class="stat-card">
                <h3>Total Revenue</h3>
                <div class="stat-value">LKR <fmt:formatNumber value="${totalRevenue}" type="number" minFractionDigits="2"/></div>
            </div>
            <div class="stat-card">
                <h3>Completed Payments</h3>
                <div class="stat-value">${completedCount}</div>
            </div>
            <div class="stat-card">
                <h3>Pending Payments</h3>
                <div class="stat-value">${pendingCount}</div>
            </div>
            <div class="stat-card">
                <h3>Failed Payments</h3>
                <div class="stat-value">${failedCount}</div>
            </div>
        </div>

        <!-- Search and Filter -->
        <div class="filter-card">
            <form method="GET" action="<c:url value='/admin/payments'/>">
                <div class="filter-grid">
                    <div class="form-group">
                        <label class="form-label">Booking ID</label>
                        <input type="number" class="form-control" name="bookingId" placeholder="Enter Booking ID" value="${param.bookingId}">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Payment Status</label>
                        <select class="form-select" name="status">
                            <option value="">All Status</option>
                            <option value="Pending" ${param.status == 'Pending' ? 'selected' : ''}>Pending</option>
                            <option value="Completed" ${param.status == 'Completed' ? 'selected' : ''}>Completed</option>
                            <option value="Failed" ${param.status == 'Failed' ? 'selected' : ''}>Failed</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">From Date</label>
                        <input type="date" class="form-control" name="fromDate" value="${param.fromDate}">
                    </div>
                    <div class="form-group">
                        <label class="form-label">To Date</label>
                        <input type="date" class="form-control" name="toDate" value="${param.toDate}">
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary" style="width: 100%;">
                            <i class="fas fa-search"></i> Search
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <!-- Payments Table -->
        <div class="table-card">
            <div class="table-header">
                <h2><i class="fas fa-list"></i> Payment Records</h2>
            </div>
            <div class="table-responsive">
                <table>
                    <thead>
                        <tr>
                            <th>Payment ID</th>
                            <th>Booking ID</th>
                            <th>Amount</th>
                            <th>Payment Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="payment" items="${payments}">
                            <tr>
                                <td><strong>#${payment.paymentId}</strong></td>
                                <td>
                                    <a href="<c:url value='/admin/bookings/${payment.bookingId}'/>" style="color: #16a34a; font-weight: 600;">
                                        BK-${payment.bookingId}
                                    </a>
                                </td>
                                <td>
                                    <strong style="color: #15803d;">LKR <fmt:formatNumber value="${payment.amount}" type="number" minFractionDigits="2"/></strong>
                                </td>
                                <td>${payment.paymentDate}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${payment.paymentStatus == 'PENDING'}">
                                            <span class="badge badge-warning">Pending</span>
                                        </c:when>
                                        <c:when test="${payment.paymentStatus == 'COMPLETED'}">
                                            <span class="badge badge-success">Completed</span>
                                        </c:when>
                                        <c:when test="${payment.paymentStatus == 'FAILED'}">
                                            <span class="badge badge-danger">Failed</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-secondary">${payment.paymentStatus}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="<c:url value='/admin/payments/${payment.paymentId}'/>" class="btn btn-sm btn-secondary" title="View Details">
                                            <i class="fas fa-eye"></i> View
                                        </a>
                                        <c:if test="${payment.paymentStatus == 'PENDING'}">
                                            <form method="POST" action="<c:url value='/admin/payments/${payment.paymentId}/complete'/>" style="display: inline;">
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                <button type="submit" class="btn btn-sm btn-primary" title="Mark as Completed">
                                                    <i class="fas fa-check"></i> Complete
                                                </button>
                                            </form>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty payments}">
                            <tr>
                                <td colspan="6">
                                    <div class="empty-state">
                                        <i class="fas fa-receipt"></i>
                                        <p>No payments found.</p>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <c:if test="${totalPages > 1}">
                <div class="pagination">
                    <c:if test="${currentPage > 0}">
                        <a href="?page=${currentPage - 1}&size=${pageSize}${not empty param.status ? '&status='.concat(param.status) : ''}">
                            <i class="fas fa-chevron-left"></i> Previous
                        </a>
                    </c:if>
                    
                    <c:forEach begin="0" end="${totalPages - 1}" var="i">
                        <c:choose>
                            <c:when test="${i == currentPage}">
                                <span class="active">${i + 1}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="?page=${i}&size=${pageSize}${not empty param.status ? '&status='.concat(param.status) : ''}">${i + 1}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    
                    <c:if test="${currentPage < totalPages - 1}">
                        <a href="?page=${currentPage + 1}&size=${pageSize}${not empty param.status ? '&status='.concat(param.status) : ''}">
                            Next <i class="fas fa-chevron-right"></i>
                        </a>
                    </c:if>
                </div>
            </c:if>
        </div>
    </div>
</main>

<%@ include file="../admin-footer.jsp" %>
