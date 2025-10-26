<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../admin-header.jsp" %>

<style>
    .user-detail-container {
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
    }
    
    .content-header h1 {
        color: #15803d;
        font-size: 2rem;
        font-weight: 700;
        margin: 0;
        display: flex;
        align-items: center;
        gap: 1rem;
    }
    
    .card {
        border: none;
        border-radius: 1rem;
        box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
        margin-bottom: 1.5rem;
        background: #ffffff;
    }
    
    .card-header {
        background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%);
        border-bottom: 2px solid #16a34a;
        border-radius: 1rem 1rem 0 0 !important;
        padding: 1.25rem;
    }
    
    .card-header h5 {
        color: #15803d;
        font-weight: 600;
        margin: 0;
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }
    
    .info-row {
        display: flex;
        padding: 1rem 0;
        border-bottom: 1px solid #f3f4f6;
    }
    
    .info-row:last-child {
        border-bottom: none;
    }
    
    .info-label {
        font-weight: 600;
        color: #374151;
        width: 150px;
        flex-shrink: 0;
    }
    
    .info-value {
        color: #6b7280;
        flex: 1;
    }
    
    .role-badge {
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        padding: 0.5rem 1rem;
        border-radius: 9999px;
        font-size: 0.875rem;
        font-weight: 500;
    }
    
    .role-admin {
        background: #fef3c7;
        color: #92400e;
        border: 1px solid #fbbf24;
    }
    
    .role-user {
        background: #dbeafe;
        color: #1e40af;
        border: 1px solid #60a5fa;
    }
    
    .btn {
        padding: 0.625rem 1.5rem;
        border-radius: 0.5rem;
        font-weight: 500;
        transition: all 0.3s;
        border: none;
        cursor: pointer;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
    }
    
    .btn-secondary {
        background: #6b7280;
        color: white;
    }
    
    .btn-secondary:hover {
        background: #4b5563;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(107, 114, 128, 0.3);
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
    
    .btn-danger {
        background: #ef4444;
        color: white;
    }
    
    .btn-danger:hover {
        background: #dc2626;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
    }
    
    .action-buttons {
        display: flex;
        gap: 1rem;
        margin-top: 1.5rem;
    }
    
    .user-avatar-large {
        width: 80px;
        height: 80px;
        border-radius: 50%;
        background: linear-gradient(135deg, #16a34a 0%, #22c55e 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-weight: 700;
        font-size: 2rem;
        margin-bottom: 1rem;
    }
</style>

<div class="user-detail-container">
    <div class="content-header">
        <div class="d-flex justify-content-between align-items-center">
            <h1><i class="fas fa-user-circle"></i> User Details</h1>
            <a href="/admin/users" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Back to Users
            </a>
        </div>
    </div>

    <div class="row">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <h5><i class="fas fa-info-circle"></i> User Information</h5>
                </div>
                <div class="card-body">
                    <div class="text-center mb-4">
                        <div class="user-avatar-large">
                            ${user.name != null && !user.name.isEmpty() ? user.name.substring(0, 1).toUpperCase() : 'U'}
                        </div>
                    </div>
                    
                    <div class="info-row">
                        <div class="info-label">User ID:</div>
                        <div class="info-value">#${user.id}</div>
                    </div>
                    
                    <div class="info-row">
                        <div class="info-label">Full Name:</div>
                        <div class="info-value">${user.name != null ? user.name : 'N/A'}</div>
                    </div>
                    
                    <div class="info-row">
                        <div class="info-label">Email:</div>
                        <div class="info-value">${user.email}</div>
                    </div>
                    
                    <div class="info-row">
                        <div class="info-label">Contact Number:</div>
                        <div class="info-value">${user.contactNum != null ? user.contactNum : 'N/A'}</div>
                    </div>
                    
                    <div class="info-row">
                        <div class="info-label">Roles:</div>
                        <div class="info-value">
                            <c:forEach var="role" items="${user.roles}" varStatus="status">
                                <c:choose>
                                    <c:when test="${role.name == 'ROLE_ADMIN'}">
                                        <span class="role-badge role-admin">
                                            <i class="fas fa-crown"></i> ADMIN
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="role-badge role-user">
                                            <i class="fas fa-user"></i> USER
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${!status.last}">, </c:if>
                            </c:forEach>
                            <c:if test="${empty user.roles}">
                                <span class="text-muted">No roles assigned</span>
                            </c:if>
                        </div>
                    </div>
                    
                    <div class="info-row">
                        <div class="info-label">Account Created:</div>
                        <div class="info-value">
                            <c:choose>
                                <c:when test="${user.createdAt != null}">
                                    <fmt:formatDate value="${user.createdAt}" pattern="MMM dd, yyyy HH:mm"/>
                                </c:when>
                                <c:otherwise>N/A</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    
                    <div class="info-row">
                        <div class="info-label">Status:</div>
                        <div class="info-value">
                            <c:choose>
                                <c:when test="${user.isGuest}">
                                    <span class="role-badge" style="background: #fef3c7; color: #92400e; border: 1px solid #fbbf24;">
                                        <i class="fas fa-user-clock"></i> Guest
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="role-badge" style="background: #d1fae5; color: #065f46; border: 1px solid #16a34a;">
                                        <i class="fas fa-check-circle"></i> Active
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="card">
                <div class="card-header">
                    <h5><i class="fas fa-cog"></i> Actions</h5>
                </div>
                <div class="card-body">
                    <div class="d-grid gap-2">
                        <a href="/admin/users/${user.id}/edit" class="btn btn-primary">
                            <i class="fas fa-edit"></i> Edit User
                        </a>
                        <button onclick="deleteUser()" class="btn btn-danger">
                            <i class="fas fa-trash"></i> Delete User
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../admin-footer.jsp" %>

<script>
    function deleteUser() {
        if (confirm('Are you sure you want to delete this user? This action cannot be undone.')) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '/admin/users/${user.id}/delete';
            
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
