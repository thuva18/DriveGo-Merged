<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../admin-header.jsp" %>

<!-- Payment Management Page -->
<div class="page-header">
    <div>
        <h1 class="page-title">Payment Management</h1>
        <p class="page-subtitle">Manage and monitor all payment transactions</p>
    </div>
    <div class="page-actions">
        <a href="<c:url value='/payments/new'/>" class="btn btn-primary">
            <i class="fas fa-plus"></i>
            New Payment
        </a>
    </div>
</div>

<!-- Filters -->
<div class="filters">
    <div class="filter-group">
        <label class="filter-label">Status</label>
        <div class="select">
            <select name="status">
                <option value="">All Status</option>
                <option value="PENDING">Pending</option>
                <option value="COMPLETED">Completed</option>
                <option value="FAILED">Failed</option>
                <option value="REFUNDED">Refunded</option>
            </select>
        </div>
    </div>
    <div class="filter-group">
        <label class="filter-label">Date Range</label>
        <input type="date" class="form-control" name="fromDate">
    </div>
    <div class="filter-group">
        <label class="filter-label">To</label>
        <input type="date" class="form-control" name="toDate">
    </div>
    <button class="btn btn-secondary" type="button">
        <i class="fas fa-search"></i>
        Search
    </button>
</div>

<!-- Payments Table -->
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

        <main class="main-content">
            <div class="content-header">
                <h1><i class="fas fa-credit-card"></i> Payment Management</h1>
                <a href="/payments/new" class="btn btn-primary">
                    <i class="fas fa-plus"></i> New Payment
                </a>
            </div>

            <!-- Flash Messages -->
            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    ${success}
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    ${error}
                </div>
            </c:if>

            <!-- Search and Filter -->
            <div class="card">
                <div class="card-header">
                    <h3>Search & Filter</h3>
                </div>
                <div class="card-body">
                    <form method="GET" action="/payments" class="filter-form">
                        <div class="form-group">
                            <label>Booking ID</label>
                            <input type="number" class="form-control" name="bookingId" placeholder="Enter Booking ID" value="${param.bookingId}">
                        </div>
                        <div class="form-group">
                            <label>Payment Status</label>
                            <select class="form-control" name="status">
                                <option value="">All Status</option>
                                <option value="PENDING" ${param.status == 'PENDING' ? 'selected' : ''}>Pending</option>
                                <option value="COMPLETED" ${param.status == 'COMPLETED' ? 'selected' : ''}>Completed</option>
                                <option value="FAILED" ${param.status == 'FAILED' ? 'selected' : ''}>Failed</option>
                                <option value="REFUNDED" ${param.status == 'REFUNDED' ? 'selected' : ''}>Refunded</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Payment Method</label>
                            <select class="form-control" name="method">
                                <option value="">All Methods</option>
                                <option value="CASH" ${param.method == 'CASH' ? 'selected' : ''}>Cash</option>
                                <option value="CREDIT_CARD" ${param.method == 'CREDIT_CARD' ? 'selected' : ''}>Credit Card</option>
                                <option value="DEBIT_CARD" ${param.method == 'DEBIT_CARD' ? 'selected' : ''}>Debit Card</option>
                                <option value="BANK_TRANSFER" ${param.method == 'BANK_TRANSFER' ? 'selected' : ''}>Bank Transfer</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-search"></i> Search
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Payments Table -->
            <div class="table-container">
                <div class="table-header">
                    <h3><i class="fas fa-list"></i> Payment Records</h3>
                </div>
                <div class="table-wrapper">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Booking ID</th>
                                <th>Amount</th>
                                <th>Method</th>
                                <th>Status</th>
                                <th>Transaction ID</th>
                                <th>Created</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="payment" items="${payments}">
                                <tr>
                                    <td><strong>#${payment.id}</strong></td>
                                    <td>
                                        <a href="/bookings/${payment.bookingId}" class="link">
                                            #${payment.bookingId}
                                        </a>
                                    </td>
                                    <td>
                                        <strong class="text-success">LKR <fmt:formatNumber value="${payment.amount}" type="number" minFractionDigits="2"/></strong>
                                    </td>
                                    <td>
                                        <span class="badge badge-info">${payment.paymentMethod}</span>
                                    </td>
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
                                            <c:when test="${payment.paymentStatus == 'REFUNDED'}">
                                                <span class="badge badge-secondary">Refunded</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-secondary">${payment.paymentStatus}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <code class="transaction-code">${payment.transactionId}</code>
                                    </td>
                                    <td><fmt:formatDate value="${payment.createdAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="/payments/${payment.id}" class="btn btn-sm btn-secondary" title="View Details">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <div class="dropdown">
                                                <button class="btn btn-sm btn-primary dropdown-toggle" onclick="toggleDropdown(this)">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <div class="dropdown-menu">
                                                    <a href="#" class="dropdown-item status-update" data-payment-id="${payment.id}" data-status="COMPLETED">Mark Completed</a>
                                                    <a href="#" class="dropdown-item status-update" data-payment-id="${payment.id}" data-status="FAILED">Mark Failed</a>
                                                    <a href="#" class="dropdown-item status-update" data-payment-id="${payment.id}" data-status="REFUNDED">Mark Refunded</a>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <div class="pagination-wrapper">
                        <div class="pagination">
                            <c:if test="${currentPage > 0}">
                                <a href="?page=${currentPage - 1}&size=10" class="page-link">
                                    <i class="fas fa-chevron-left"></i> Previous
                                </a>
                            </c:if>

                            <c:forEach begin="0" end="${totalPages - 1}" var="page">
                                <a href="?page=${page}&size=10" class="page-link ${page == currentPage ? 'active' : ''}">
                                    ${page + 1}
                                </a>
                            </c:forEach>

                            <c:if test="${currentPage < totalPages - 1}">
                                <a href="?page=${currentPage + 1}&size=10" class="page-link">
                                    Next <i class="fas fa-chevron-right"></i>
                                </a>
                            </c:if>
                        </div>
                    </div>
                </c:if>
            </div>
        </main>

<%@ include file="../admin-footer.jsp" %>

<script>
    // Dropdown functionality
    function toggleDropdown(button) {
        const dropdown = button.parentElement;
        const menu = dropdown.querySelector('.dropdown-menu');
        
        // Close all other dropdowns
        document.querySelectorAll('.dropdown-menu').forEach(m => {
            if (m !== menu) m.classList.remove('show');
        });
        
        menu.classList.toggle('show');
    }

    // Close dropdown when clicking outside
    document.addEventListener('click', function(event) {
        if (!event.target.closest('.dropdown')) {
            document.querySelectorAll('.dropdown-menu').forEach(menu => {
                menu.classList.remove('show');
            });
        }
    });

    // Handle status updates
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.status-update').forEach(link => {
            link.addEventListener('click', function(e) {
                e.preventDefault();
                const paymentId = this.dataset.paymentId;
                const status = this.dataset.status;
                
                if (confirm('Are you sure you want to update the payment status to ' + status + '?')) {
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = '/payments/' + paymentId + '/status';
                    
                    const statusInput = document.createElement('input');
                    statusInput.type = 'hidden';
                    statusInput.name = 'status';
                    statusInput.value = status;
                    
                    form.appendChild(statusInput);
                    document.body.appendChild(form);
                    form.submit();
                }
            });
        });
    });
</script>
