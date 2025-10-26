<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../admin-header.jsp" %>

<style>
    .user-form-container {
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
    }
    
    .form-card {
        background: #ffffff;
        border-radius: 1rem;
        box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
        padding: 2rem;
    }
    
    .form-group {
        margin-bottom: 1.5rem;
    }
    
    .form-label {
        font-weight: 600;
        color: #374151;
        margin-bottom: 0.5rem;
        display: block;
    }
    
    .form-control {
        width: 100%;
        padding: 0.75rem;
        border: 2px solid #e5e7eb;
        border-radius: 0.5rem;
        font-size: 1rem;
        transition: all 0.3s;
    }
    
    .form-control:focus {
        outline: none;
        border-color: #16a34a;
        box-shadow: 0 0 0 3px rgba(22, 163, 74, 0.1);
    }
    
    .btn {
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
        background: #6b7280;
        color: white;
    }
    
    .btn-secondary:hover {
        background: #4b5563;
    }
    
    .role-selector {
        display: flex;
        gap: 1rem;
        flex-wrap: wrap;
    }
    
    .role-option {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        padding: 0.75rem 1.25rem;
        border: 2px solid #e5e7eb;
        border-radius: 0.5rem;
        cursor: pointer;
        transition: all 0.3s;
    }
    
    .role-option:has(input:checked) {
        border-color: #16a34a;
        background: #f0fdf4;
    }
    
    .role-option input {
        width: 18px;
        height: 18px;
        cursor: pointer;
    }
</style>

<div class="user-form-container">
    <div class="content-header">
        <div class="d-flex justify-content-between align-items-center">
            <h1><i class="fas fa-user-plus"></i> Add New User</h1>
            <a href="/admin/users" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Back
            </a>
        </div>
    </div>

    <!-- Error Messages -->
    <c:if test="${not empty error}">
        <div class="alert alert-error" style="background: #fee2e2; border: 1px solid #ef4444; padding: 1rem; border-radius: 0.5rem; margin-bottom: 1.5rem;">
            <i class="fas fa-exclamation-circle" style="color: #ef4444;"></i>
            <span style="color: #991b1b;">${error}</span>
        </div>
    </c:if>

    <div class="form-card">
        <form action="/admin/users/create" method="post" id="createUserForm">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="form-label">First Name</label>
                        <input type="text" name="firstName" class="form-control" required/>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="form-label">Last Name</label>
                        <input type="text" name="lastName" class="form-control" required/>
                    </div>
                </div>
            </div>
            
            <div class="form-group">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control" required/>
            </div>
            
            <div class="form-group">
                <label class="form-label">Phone Number</label>
                <input type="tel" name="mobile" class="form-control" placeholder="+1234567890"/>
            </div>
            
            <div class="form-group">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-control" required 
                       placeholder="Minimum 8 characters"/>
            </div>
            
            <div class="form-group">
                <label class="form-label">Assign Role (Select One)</label>
                <div class="role-selector">
                    <c:forEach var="role" items="${allRoles}">
                        <label class="role-option">
                            <input type="radio" name="role" value="${role.name}" required
                                   <c:if test="${role.name == 'ROLE_USER'}">checked</c:if>
                            />
                            <span>${role.name.replace('ROLE_', '')}</span>
                        </label>
                    </c:forEach>
                </div>
            </div>
            
            <div class="d-flex gap-3 mt-4">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Create User
                </button>
                <a href="/admin/users" class="btn btn-secondary">
                    <i class="fas fa-times"></i> Cancel
                </a>
            </div>
        </form>
    </div>
</div>

<%@ include file="../admin-footer.jsp" %>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const form = document.querySelector('form');
    const submitButton = form.querySelector('button[type="submit"]');
    const originalButtonText = submitButton.innerHTML;
    
    form.addEventListener('submit', function(e) {
        // Disable button to prevent double submission
        submitButton.disabled = true;
        submitButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Creating User...';
        
        // Show processing feedback
        const processingDiv = document.createElement('div');
        processingDiv.innerHTML = `
            <div style="background: #dbeafe; border: 1px solid #3b82f6; padding: 1rem; border-radius: 0.5rem; margin-top: 1rem;">
                <i class="fas fa-info-circle" style="color: #3b82f6;"></i>
                <span style="color: #1e40af;">Processing your request... Please wait.</span>
            </div>
        `;
        form.appendChild(processingDiv);
        
        // Re-enable button after 10 seconds as fallback
        setTimeout(() => {
            submitButton.disabled = false;
            submitButton.innerHTML = originalButtonText;
            if (processingDiv.parentNode) {
                processingDiv.remove();
            }
        }, 10000);
    });
    
    // Form validation enhancement
    const requiredFields = form.querySelectorAll('[required]');
    requiredFields.forEach(field => {
        field.addEventListener('blur', function() {
            if (this.value.trim() === '') {
                this.style.borderColor = '#ef4444';
            } else {
                this.style.borderColor = '#16a34a';
            }
        });
    });
});
</script>
