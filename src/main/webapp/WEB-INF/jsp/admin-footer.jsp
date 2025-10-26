        </div>
    </main>
</div>

<!-- Footer -->
<footer class="footer">
    <div class="footer-content">
        <div class="footer-left">
            <div class="footer-logo">
                <i class="fas fa-car"></i>
                <span>DriveGo</span>
            </div>
            <p>&copy; 2025 DriveGo. All rights reserved.</p>
        </div>
        <div class="footer-right">
            <p>Professional Car Management System</p>
        </div>
    </div>
</footer>

<!-- JavaScript for Mobile Menu and Interactive Features -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Mobile Menu Toggle
    const mobileMenuBtn = document.getElementById('mobileMenuBtn');
    const sidebar = document.getElementById('sidebar');
    const sidebarOverlay = document.getElementById('sidebarOverlay');
    
    if (mobileMenuBtn && sidebar && sidebarOverlay) {
        mobileMenuBtn.addEventListener('click', function() {
            sidebar.classList.toggle('open');
            sidebarOverlay.classList.toggle('active');
        });
        
        sidebarOverlay.addEventListener('click', function() {
            sidebar.classList.remove('open');
            sidebarOverlay.classList.remove('active');
        });
    }
    
    // User Menu Dropdown
    const userMenu = document.getElementById('userMenu');
    const userDropdown = document.getElementById('userDropdown');
    
    if (userMenu && userDropdown) {
        userMenu.addEventListener('click', function(e) {
            e.stopPropagation();
            this.classList.toggle('active');
        });
        
        // Close dropdown when clicking outside
        document.addEventListener('click', function(e) {
            if (!userMenu.contains(e.target)) {
                userMenu.classList.remove('active');
            }
        });
        
        // Prevent dropdown from closing when clicking inside
        userDropdown.addEventListener('click', function(e) {
            e.stopPropagation();
        });
    }
    
    // Active Navigation Link - Enhanced for nested routes
    const currentPath = window.location.pathname;
    const navLinks = document.querySelectorAll('.nav-link');
    
    // Remove all active classes first
    navLinks.forEach(link => link.classList.remove('active'));
    
    // Find the best matching link
    let bestMatch = null;
    let longestMatchLength = 0;
    
    navLinks.forEach(link => {
        const linkPath = link.getAttribute('href');
        
        // Skip root paths or empty hrefs
        if (!linkPath || linkPath === '/' || linkPath === '#') {
            return;
        }
        
        // Check if current path starts with the link path (for nested routes)
        if (currentPath.startsWith(linkPath)) {
            const matchLength = linkPath.length;
            if (matchLength > longestMatchLength) {
                longestMatchLength = matchLength;
                bestMatch = link;
            }
        }
    });
    
    // Add active class to the best match
    if (bestMatch) {
        bestMatch.classList.add('active');
    }
    
    // Auto-hide alerts
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(alert => {
        if (alert.classList.contains('success')) {
            setTimeout(() => {
                alert.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                alert.style.opacity = '0';
                alert.style.transform = 'translateY(-20px)';
                setTimeout(() => alert.remove(), 500);
            }, 3000);
        }
    });
    
    // Enhanced form validation feedback
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        const inputs = form.querySelectorAll('.form-control');
        inputs.forEach(input => {
            input.addEventListener('blur', function() {
                validateInput(this);
            });
            
            input.addEventListener('input', function() {
                if (this.classList.contains('error')) {
                    validateInput(this);
                }
            });
        });
    });
    
    function validateInput(input) {
        const value = input.value.trim();
        const required = input.hasAttribute('required');
        const type = input.getAttribute('type');
        
        // Remove existing error state
        input.classList.remove('error');
        const existingError = input.parentNode.querySelector('.form-error');
        if (existingError) existingError.remove();
        
        // Validate
        let isValid = true;
        let errorMessage = '';
        
        if (required && !value) {
            isValid = false;
            errorMessage = 'This field is required';
        } else if (type === 'email' && value && !isValidEmail(value)) {
            isValid = false;
            errorMessage = 'Please enter a valid email address';
        }
        
        if (!isValid) {
            input.classList.add('error');
            const errorDiv = document.createElement('div');
            errorDiv.className = 'form-error';
            errorDiv.innerHTML = `<i class="fas fa-exclamation-triangle"></i> ${errorMessage}`;
            input.parentNode.appendChild(errorDiv);
        }
        
        return isValid;
    }
    
    function isValidEmail(email) {
        return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
    }
    
    // Enhanced table interactions
    const tables = document.querySelectorAll('.table');
    tables.forEach(table => {
        const rows = table.querySelectorAll('tbody tr');
        rows.forEach(row => {
            row.classList.add('row-hover');
        });
    });
    
    // Smooth scroll for anchor links
    const anchorLinks = document.querySelectorAll('a[href^="#"]');
    anchorLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({ behavior: 'smooth' });
            }
        });
    });
});

// Global functions for status updates (used in JSP pages)
function updateStatus(id, status, type = 'booking') {
    if (!confirm(`Are you sure you want to update this ${type} status to ${status}?`)) {
        return;
    }
    
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = `/${type}s/${id}/status`;
    
    const statusInput = document.createElement('input');
    statusInput.type = 'hidden';
    statusInput.name = 'status';
    statusInput.value = status;
    
    form.appendChild(statusInput);
    document.body.appendChild(form);
    form.submit();
}

function deleteItem(id, type = 'item') {
    if (!confirm(`Are you sure you want to delete this ${type}? This action cannot be undone.`)) {
        return;
    }
    
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = `/${type}s/${id}/delete`;
    
    document.body.appendChild(form);
    form.submit();
}
</script>

</body>
</html>
