<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../admin-header.jsp" %>

<style>
    /* User Management - Clean White Theme with Green Accents */
    .user-container {
        padding: 2rem;
        background: #f8fafb;
        min-height: calc(100vh - 4rem);
    }

    .user-page-header {
        background: linear-gradient(135deg, #ffffff 0%, #f0fdf4 100%);
        padding: 2rem;
        border-radius: 1rem;
        margin-bottom: 2rem;
        border: 2px solid #16a34a;
        box-shadow: 0 4px 20px rgba(22, 163, 74, 0.1);
    }

    .user-page-header h1 {
        color: #15803d;
        font-size: 2rem;
        font-weight: 700;
        margin: 0 0 0.5rem 0;
        display: flex;
        align-items: center;
        gap: 1rem;
    }

    .user-page-header p {
        color: #6b7280;
        margin: 0;
        font-size: 1rem;
    }

    .users-table-card {
        background: #ffffff;
        border-radius: 1rem;
        box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
        overflow: hidden;
    }

    .table-header {
        background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%);
        padding: 1.5rem;
        border-bottom: 2px solid #16a34a;
    }

    .table-header h2 {
        color: #15803d;
        font-size: 1.25rem;
        font-weight: 600;
        margin: 0;
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }

    .users-table {
        width: 100%;
        margin: 0;
    }

    .users-table thead {
        background: #f9fafb;
        border-bottom: 2px solid #e5e7eb;
    }

    .users-table th {
        padding: 1rem 1.5rem;
        text-align: left;
        font-weight: 600;
        color: #374151;
        font-size: 0.875rem;
        text-transform: uppercase;
        letter-spacing: 0.05em;
    }

    .users-table td {
        padding: 1rem 1.5rem;
        border-bottom: 1px solid #f3f4f6;
        vertical-align: middle;
    }

    .users-table tbody tr {
        transition: all 0.2s;
    }

    .users-table tbody tr:hover {
        background-color: #f9fafb;
    }

    .user-info {
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }

    .user-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background: linear-gradient(135deg, #16a34a 0%, #22c55e 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-weight: 600;
        font-size: 1rem;
    }

    .user-details {
        flex: 1;
    }

    .user-name {
        font-weight: 600;
        color: #1f2937;
        margin-bottom: 0.25rem;
    }

    .user-email {
        color: #6b7280;
        font-size: 0.875rem;
    }

    .role-badge {
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        padding: 0.375rem 0.875rem;
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

    .action-buttons {
        display: flex;
        gap: 0.5rem;
    }

    .btn-action {
        padding: 0.5rem 1rem;
        border-radius: 0.5rem;
        font-size: 0.875rem;
        font-weight: 500;
        transition: all 0.3s;
        border: none;
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        text-decoration: none;
    }

    .btn-view {
        background: #dbeafe;
        color: #1e40af;
    }

    .btn-view:hover {
        background: #bfdbfe;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(30, 64, 175, 0.2);
    }

    .btn-edit {
        background: #d1fae5;
        color: #065f46;
    }

    .btn-edit:hover {
        background: #a7f3d0;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(6, 95, 70, 0.2);
    }

    .btn-delete {
        background: #fee2e2;
        color: #991b1b;
    }

    .btn-delete:hover {
        background: #fecaca;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(153, 27, 27, 0.2);
    }

    .btn-add-user {
        background: #16a34a;
        color: white;
        padding: 0.75rem 1.5rem;
        border-radius: 0.5rem;
        font-weight: 600;
        border: none;
        cursor: pointer;
        transition: all 0.3s;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
    }

    .btn-add-user:hover {
        background: #15803d;
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(22, 163, 74, 0.3);
    }

    .alert {
        padding: 1rem 1.5rem;
        border-radius: 0.75rem;
        margin-bottom: 1.5rem;
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }

    .alert-success {
        background: #d1fae5;
        border: 1px solid #16a34a;
        color: #065f46;
    }

    .alert-error {
        background: #fee2e2;
        border: 1px solid #ef4444;
        color: #991b1b;
    }

    .alert i {
        font-size: 1.25rem;
    }

    .empty-state {
        text-align: center;
        padding: 4rem 2rem;
        color: #6b7280;
    }

    .empty-state i {
        font-size: 4rem;
        color: #d1d5db;
        margin-bottom: 1rem;
    }

    .empty-state h3 {
        color: #374151;
        margin-bottom: 0.5rem;
    }

    .empty-state p {
        color: #9ca3af;
        margin-bottom: 2rem;
    }
</style>

<div class="user-container">
    <div class="user-page-header">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h1><i class="fas fa-users-cog"></i> User Management</h1>
                <p>Manage user accounts, roles, and permissions</p>
            </div>
            <a href="/admin/users/new" class="btn-add-user">
                <i class="fas fa-plus"></i> Add New User
            </a>
        </div>
    </div>

    <!-- Flash Messages -->
    <c:if test="${not empty success}">
        <div class="alert alert-success" id="successAlert">
            <i class="fas fa-check-circle"></i>
            <span>${success}</span>
            <c:if test="${not empty created}">
                <br><small><i class="fas fa-sync-alt"></i> User table refreshed automatically</small>
            </c:if>
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-error" id="errorAlert">
            <i class="fas fa-exclamation-circle"></i>
            <span>${error}</span>
        </div>
    </c:if>

    <div class="users-table-card">
        <div class="table-header">
            <h2><i class="fas fa-list"></i> All Users</h2>
        </div>

        <c:choose>
            <c:when test="${empty users}">
                <div class="empty-state">
                    <i class="fas fa-users"></i>
                    <h3>No Users Found</h3>
                    <p>Start by adding your first user to the system</p>
                    <a href="/admin/users/new" class="btn-add-user">
                        <i class="fas fa-plus"></i> Add First User
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <table class="users-table">
                    <thead>
                        <tr>
                            <th>User</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Role</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${users}">
                            <tr>
                                <td>
                                    <div class="user-info">
                                        <div class="user-avatar">
                                            ${user.firstName.substring(0, 1).toUpperCase()}
                                        </div>
                                        <div class="user-details">
                                            <div class="user-name">${user.firstName} ${user.lastName}</div>
                                            <div class="user-email">ID: ${user.id}</div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <span>${user.email}</span>
                                </td>
                                <td>
                                    <span>${user.mobile != null ? user.mobile : 'N/A'}</span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${user.roles != null && not empty user.roles}">
                                            <c:forEach var="role" items="${user.roles}" varStatus="status">
                                                <c:choose>
                                                    <c:when test="${role == 'ROLE_ADMIN'}">
                                                        <span class="role-badge role-admin">
                                                            <i class="fas fa-crown"></i> ADMIN
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${role == 'ROLE_USER'}">
                                                        <span class="role-badge role-user">
                                                            <i class="fas fa-user"></i> USER
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="role-badge role-user">
                                                            <i class="fas fa-user-cog"></i> ${role.replace('ROLE_', '')}
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:if test="${!status.last}"> </c:if>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="role-badge role-user">
                                                <i class="fas fa-question"></i> NO ROLE
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="/admin/users/${user.id}" class="btn-action btn-view">
                                            <i class="fas fa-eye"></i> View
                                        </a>
                                        <a href="/admin/users/${user.id}/edit" class="btn-action btn-edit">
                                            <i class="fas fa-edit"></i> Edit
                                        </a>
                                        <button onclick="deleteUser(${user.id})" class="btn-action btn-delete">
                                            <i class="fas fa-trash"></i> Delete
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="../admin-footer.jsp" %>

<script>
    function deleteUser(userId) {
        if (confirm('Are you sure you want to delete this user? This action cannot be undone.')) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '/admin/users/' + userId + '/delete';
            
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
    
    // Auto-refresh functionality
    document.addEventListener('DOMContentLoaded', function() {
        // Check if user was just created
        const urlParams = new URLSearchParams(window.location.search);
        const isNewUserCreated = urlParams.get('created');
        
        if (isNewUserCreated) {
            // Highlight the latest user (first row in table)
            const firstUserRow = document.querySelector('.users-table tbody tr:first-child');
            if (firstUserRow) {
                firstUserRow.style.backgroundColor = '#d1fae5';
                firstUserRow.style.border = '2px solid #16a34a';
                firstUserRow.style.transition = 'all 0.3s ease';
                
                // Remove highlight after 5 seconds
                setTimeout(() => {
                    firstUserRow.style.backgroundColor = '';
                    firstUserRow.style.border = '';
                }, 5000);
            }
            
            // Auto-hide success message after 8 seconds
            const successAlert = document.getElementById('successAlert');
            if (successAlert) {
                setTimeout(() => {
                    successAlert.style.opacity = '0';
                    successAlert.style.transition = 'opacity 0.5s ease';
                    setTimeout(() => {
                        successAlert.style.display = 'none';
                    }, 500);
                }, 8000);
            }
            
            // Clean URL without refreshing page
            const newUrl = window.location.protocol + "//" + window.location.host + window.location.pathname;
            window.history.replaceState({}, document.title, newUrl);
        }
        
        // Auto-hide error messages after 10 seconds
        const errorAlert = document.getElementById('errorAlert');
        if (errorAlert) {
            setTimeout(() => {
                errorAlert.style.opacity = '0';
                errorAlert.style.transition = 'opacity 0.5s ease';
                setTimeout(() => {
                    errorAlert.style.display = 'none';
                }, 500);
            }, 10000);
        }
    });
</script>
