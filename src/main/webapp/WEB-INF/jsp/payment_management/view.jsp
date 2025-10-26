<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../admin-header.jsp" %>

<style>
    .payment-view-container {
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
    
    .detail-card {
        background: #ffffff;
        border-radius: 1rem;
        box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
        padding: 2rem;
        margin-bottom: 1.5rem;
    }
    
    .detail-row {
        display: grid;
        grid-template-columns: 200px 1fr;
        padding: 1rem 0;
        border-bottom: 1px solid #f1f5f9;
    }
    
    .detail-row:last-child {
        border-bottom: none;
    }
    
    .detail-label {
        font-weight: 600;
        color: #64748b;
    }
    
    .detail-value {
        color: #1e293b;
        font-weight: 500;
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
    
    .badge {
        padding: 0.5rem 1rem;
        border-radius: 0.5rem;
        font-size: 0.875rem;
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
    
    .action-group {
        display: flex;
        gap: 1rem;
        margin-top: 2rem;
    }
    
    .status-form {
        display: flex;
        gap: 0.5rem;
        align-items: center;
    }
    
    .status-form select {
        padding: 0.75rem;
        border: 2px solid #e5e7eb;
        border-radius: 0.5rem;
        font-size: 1rem;
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
</style>

<main class="main-content">
    <div class="payment-view-container">
        <div class="content-header">
            <div>
                <h1><i class="fas fa-receipt"></i> Payment Details</h1>
                <p style="margin: 0.5rem 0 0 0; color: #64748b;">Payment #${payment.paymentId}</p>
            </div>
            <a href="<c:url value='/admin/payments'/>" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Back to List
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

        <!-- Payment Information -->
        <div class="detail-card">
            <h2 style="color: #15803d; margin-bottom: 1.5rem;">
                <i class="fas fa-info-circle"></i> Payment Information
            </h2>
            
            <div class="detail-row">
                <div class="detail-label">Payment ID:</div>
                <div class="detail-value">#${payment.paymentId}</div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Booking ID:</div>
                <div class="detail-value">
                    <a href="<c:url value='/admin/bookings/${payment.bookingId}'/>" style="color: #16a34a; font-weight: 600;">
                        BK-${payment.bookingId}
                    </a>
                </div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Amount:</div>
                <div class="detail-value" style="color: #15803d; font-size: 1.5rem; font-weight: 700;">
                    LKR <fmt:formatNumber value="${payment.amount}" type="number" minFractionDigits="2"/>
                </div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Payment Date:</div>
                <div class="detail-value">
                    ${payment.paymentDate}
                </div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Status:</div>
                <div class="detail-value">
                    <c:choose>
                        <c:when test="${payment.paymentStatus == 'PENDING'}">
                            <span class="badge badge-warning"><i class="fas fa-clock"></i> Pending</span>
                        </c:when>
                        <c:when test="${payment.paymentStatus == 'COMPLETED'}">
                            <span class="badge badge-success"><i class="fas fa-check-circle"></i> Completed</span>
                        </c:when>
                        <c:when test="${payment.paymentStatus == 'FAILED'}">
                            <span class="badge badge-danger"><i class="fas fa-times-circle"></i> Failed</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge">${payment.paymentStatus}</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Payment Method:</div>
                <div class="detail-value">
                    <span class="badge badge-info">
                        <c:choose>
                            <c:when test="${payment.paymentMethod == 'CREDIT_CARD'}">Credit Card</c:when>
                            <c:when test="${payment.paymentMethod == 'DEBIT_CARD'}">Debit Card</c:when>
                            <c:when test="${payment.paymentMethod == 'CASH'}">Cash</c:when>
                            <c:when test="${payment.paymentMethod == 'BANK_TRANSFER'}">Bank Transfer</c:when>
                            <c:otherwise>${payment.paymentMethod}</c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>
            
            <c:if test="${not empty payment.cardHolder}">
                <div class="detail-row">
                    <div class="detail-label">Card Holder:</div>
                    <div class="detail-value">${payment.cardHolder}</div>
                </div>
            </c:if>
            
            <c:if test="${not empty payment.cardNumber}">
                <div class="detail-row">
                    <div class="detail-label">Card Number:</div>
                    <div class="detail-value">**** **** **** ${payment.cardNumber.substring(payment.cardNumber.length() - 4)}</div>
                </div>
            </c:if>
        </div>

        <!-- Actions -->
        <div class="action-group">
            <c:if test="${payment.paymentStatus == 'PENDING'}">
                <form method="POST" action="<c:url value='/admin/payments/${payment.paymentId}/complete'/>" style="display: inline;">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-check"></i> Mark as Completed
                    </button>
                </form>
                
                <form method="POST" action="<c:url value='/admin/payments/${payment.paymentId}/status'/>" style="display: inline;">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <input type="hidden" name="status" value="Failed"/>
                    <button type="submit" class="btn btn-secondary">
                        <i class="fas fa-times"></i> Mark as Failed
                    </button>
                </form>
            </c:if>
        </div>
    </div>
</main>

<%@ include file="../admin-footer.jsp" %>
