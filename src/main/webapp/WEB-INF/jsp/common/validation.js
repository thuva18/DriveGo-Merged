/**
 * DriveGo - Universal Form Validation System
 * Provides comprehensive client-side validation for all forms
 */

class DriveGoValidator {
    constructor() {
        this.patterns = {
            email: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
            phone: /^[\+]?[1-9][\d]{0,15}$/,
            cardNumber: /^\d{4}\s?\d{4}\s?\d{4}\s?\d{4}$/,
            cvv: /^\d{3,4}$/,
            expiryDate: /^(0[1-9]|1[0-2])\/\d{2}$/,
            strongPassword: /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/,
            alphaOnly: /^[a-zA-Z\s]+$/,
            alphaNumeric: /^[a-zA-Z0-9\s]+$/,
            registrationNumber: /^[A-Z]{2,3}[-\s]?\d{4}$/
        };
        
        this.errorMessages = {
            required: 'This field is required',
            email: 'Please enter a valid email address',
            phone: 'Please enter a valid phone number',
            cardNumber: 'Please enter a valid card number (16 digits)',
            cvv: 'Please enter a valid CVV (3-4 digits)',
            expiryDate: 'Please enter expiry date in MM/YY format',
            strongPassword: 'Password must be at least 8 characters with uppercase, lowercase, number and special character',
            minLength: 'Minimum {min} characters required',
            maxLength: 'Maximum {max} characters allowed',
            min: 'Minimum value is {min}',
            max: 'Maximum value is {max}',
            dateRange: 'End date must be after start date',
            fileSize: 'File size must not exceed {max}MB',
            fileType: 'Please select a valid file type: {types}',
            alphaOnly: 'Only letters and spaces are allowed',
            registrationNumber: 'Please enter a valid registration number (e.g., ABC-1234)'
        };
        
        this.init();
    }
    
    init() {
        // Initialize validation on page load
        document.addEventListener('DOMContentLoaded', () => {
            this.attachValidators();
            this.setupRealTimeValidation();
        });
    }
    
    attachValidators() {
        // Find all forms and attach validation
        const forms = document.querySelectorAll('form');
        forms.forEach(form => {
            form.addEventListener('submit', (e) => {
                if (!this.validateForm(form)) {
                    e.preventDefault();
                    e.stopPropagation();
                }
            });
        });
    }
    
    setupRealTimeValidation() {
        // Real-time validation for all inputs
        const inputs = document.querySelectorAll('input, select, textarea');
        inputs.forEach(input => {
            input.addEventListener('blur', () => this.validateField(input));
            input.addEventListener('input', () => this.clearError(input));
            
            // Special handling for specific input types
            if (input.type === 'email') {
                input.addEventListener('input', () => this.validateEmail(input));
            }
            if (input.type === 'tel' || input.name.includes('phone') || input.name.includes('contact')) {
                input.addEventListener('input', () => this.validatePhone(input));
            }
            if (input.name.includes('card') || input.name.includes('Card')) {
                input.addEventListener('input', () => this.formatCardNumber(input));
            }
            if (input.name.includes('cvv') || input.name.includes('CVV')) {
                input.addEventListener('input', () => this.validateCVV(input));
            }
            if (input.name.includes('expiry') || input.name.includes('Expiry')) {
                input.addEventListener('input', () => this.formatExpiryDate(input));
            }
        });
    }
    
    validateForm(form) {
        let isValid = true;
        const inputs = form.querySelectorAll('input, select, textarea');
        
        // Clear previous errors
        this.clearAllErrors(form);
        
        inputs.forEach(input => {
            if (!this.validateField(input)) {
                isValid = false;
            }
        });
        
        // Special validations
        isValid = this.validateDateRanges(form) && isValid;
        isValid = this.validatePasswordConfirmation(form) && isValid;
        isValid = this.validatePaymentMethod(form) && isValid;
        
        return isValid;
    }
    
    validateField(input) {
        const value = input.value.trim();
        const isRequired = input.hasAttribute('required') || input.classList.contains('required');
        
        // Required field validation
        if (isRequired && !value) {
            this.showError(input, this.errorMessages.required);
            return false;
        }
        
        // Skip other validations if field is empty and not required
        if (!value && !isRequired) {
            return true;
        }
        
        // Type-specific validations
        switch (input.type) {
            case 'email':
                return this.validateEmail(input);
            case 'tel':
                return this.validatePhone(input);
            case 'number':
                return this.validateNumber(input);
            case 'date':
                return this.validateDate(input);
            case 'datetime-local':
                return this.validateDateTime(input);
            case 'password':
                return this.validatePassword(input);
            case 'file':
                return this.validateFile(input);
        }
        
        // Name-based validations
        if (input.name.includes('card') || input.name.includes('Card')) {
            return this.validateCardNumber(input);
        }
        if (input.name.includes('cvv') || input.name.includes('CVV')) {
            return this.validateCVV(input);
        }
        if (input.name.includes('expiry') || input.name.includes('Expiry')) {
            return this.validateExpiryDate(input);
        }
        if (input.name.includes('regNo') || input.name.includes('registrationNumber')) {
            return this.validateRegistrationNumber(input);
        }
        if (input.name.includes('Name') && !input.name.includes('user') && !input.name.includes('file')) {
            return this.validateName(input);
        }
        
        // Length validations
        return this.validateLength(input);
    }
    
    validateEmail(input) {
        const value = input.value.trim();
        if (value && !this.patterns.email.test(value)) {
            this.showError(input, this.errorMessages.email);
            return false;
        }
        return true;
    }
    
    validatePhone(input) {
        const value = input.value.trim();
        if (value && !this.patterns.phone.test(value)) {
            this.showError(input, this.errorMessages.phone);
            return false;
        }
        return true;
    }
    
    validateCardNumber(input) {
        const value = input.value.replace(/\s/g, '');
        if (value && (value.length !== 16 || !this.patterns.cardNumber.test(input.value))) {
            this.showError(input, this.errorMessages.cardNumber);
            return false;
        }
        return true;
    }
    
    validateCVV(input) {
        const value = input.value.trim();
        if (value && !this.patterns.cvv.test(value)) {
            this.showError(input, this.errorMessages.cvv);
            return false;
        }
        return true;
    }
    
    validateExpiryDate(input) {
        const value = input.value.trim();
        if (value && !this.patterns.expiryDate.test(value)) {
            this.showError(input, this.errorMessages.expiryDate);
            return false;
        }
        
        // Check if date is not in the past
        if (value && this.patterns.expiryDate.test(value)) {
            const [month, year] = value.split('/');
            const expiry = new Date(2000 + parseInt(year), parseInt(month) - 1);
            const now = new Date();
            now.setDate(1); // Set to first day to compare months
            
            if (expiry < now) {
                this.showError(input, 'Card has expired');
                return false;
            }
        }
        
        return true;
    }
    
    validatePassword(input) {
        const value = input.value;
        if (input.name === 'password' && value && !this.patterns.strongPassword.test(value)) {
            this.showError(input, this.errorMessages.strongPassword);
            return false;
        }
        return true;
    }
    
    validateRegistrationNumber(input) {
        const value = input.value.trim();
        if (value && !this.patterns.registrationNumber.test(value)) {
            this.showError(input, this.errorMessages.registrationNumber);
            return false;
        }
        return true;
    }
    
    validateName(input) {
        const value = input.value.trim();
        if (value && !this.patterns.alphaOnly.test(value)) {
            this.showError(input, this.errorMessages.alphaOnly);
            return false;
        }
        return true;
    }
    
    validateNumber(input) {
        const value = parseFloat(input.value);
        const min = input.getAttribute('min');
        const max = input.getAttribute('max');
        
        if (min && value < parseFloat(min)) {
            this.showError(input, this.errorMessages.min.replace('{min}', min));
            return false;
        }
        
        if (max && value > parseFloat(max)) {
            this.showError(input, this.errorMessages.max.replace('{max}', max));
            return false;
        }
        
        return true;
    }
    
    validateDate(input) {
        const value = input.value;
        if (value) {
            const date = new Date(value);
            const today = new Date();
            today.setHours(0, 0, 0, 0);
            
            // Future dates only for booking dates
            if (input.name.includes('booking') || input.name.includes('pickup') || input.name.includes('return')) {
                if (date < today) {
                    this.showError(input, 'Please select a future date');
                    return false;
                }
            }
        }
        return true;
    }
    
    validateDateTime(input) {
        const value = input.value;
        if (value) {
            const dateTime = new Date(value);
            const now = new Date();
            
            if (dateTime < now) {
                this.showError(input, 'Please select a future date and time');
                return false;
            }
        }
        return true;
    }
    
    validateFile(input) {
        const file = input.files[0];
        if (!file) return true;
        
        // File size validation (5MB max)
        const maxSize = 5 * 1024 * 1024; // 5MB
        if (file.size > maxSize) {
            this.showError(input, this.errorMessages.fileSize.replace('{max}', '5'));
            return false;
        }
        
        // File type validation
        const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'application/pdf'];
        if (!allowedTypes.includes(file.type)) {
            this.showError(input, this.errorMessages.fileType.replace('{types}', 'JPG, PNG, GIF, PDF'));
            return false;
        }
        
        return true;
    }
    
    validateLength(input) {
        const value = input.value;
        const minLength = input.getAttribute('minlength');
        const maxLength = input.getAttribute('maxlength');
        
        if (minLength && value.length < parseInt(minLength)) {
            this.showError(input, this.errorMessages.minLength.replace('{min}', minLength));
            return false;
        }
        
        if (maxLength && value.length > parseInt(maxLength)) {
            this.showError(input, this.errorMessages.maxLength.replace('{max}', maxLength));
            return false;
        }
        
        return true;
    }
    
    validateDateRanges(form) {
        // Validate pickup/return date ranges
        const pickupDate = form.querySelector('input[name*="pickup"], input[name*="from"]');
        const returnDate = form.querySelector('input[name*="return"], input[name*="to"]');
        
        if (pickupDate && returnDate && pickupDate.value && returnDate.value) {
            const pickup = new Date(pickupDate.value);
            const returnD = new Date(returnDate.value);
            
            if (returnD <= pickup) {
                this.showError(returnDate, this.errorMessages.dateRange);
                return false;
            }
        }
        
        return true;
    }
    
    validatePasswordConfirmation(form) {
        const password = form.querySelector('input[name="password"]');
        const confirmPassword = form.querySelector('input[name="confirmPassword"], input[name="password_confirmation"]');
        
        if (password && confirmPassword && password.value && confirmPassword.value) {
            if (password.value !== confirmPassword.value) {
                this.showError(confirmPassword, 'Passwords do not match');
                return false;
            }
        }
        
        return true;
    }
    
    validatePaymentMethod(form) {
        const paymentMethods = form.querySelectorAll('input[name="paymentMethod"]');
        if (paymentMethods.length > 0) {
            const isSelected = Array.from(paymentMethods).some(radio => radio.checked);
            if (!isSelected) {
                this.showError(paymentMethods[0], 'Please select a payment method');
                return false;
            }
            
            // Validate card details if card payment is selected
            const selectedMethod = form.querySelector('input[name="paymentMethod"]:checked');
            if (selectedMethod && (selectedMethod.value === 'CREDIT_CARD' || selectedMethod.value === 'DEBIT_CARD')) {
                const cardNumber = form.querySelector('input[name*="cardNumber"]');
                const cvv = form.querySelector('input[name*="cvv"]');
                const expiry = form.querySelector('input[name*="expiry"]');
                
                if (cardNumber && !cardNumber.value) {
                    this.showError(cardNumber, 'Card number is required');
                    return false;
                }
                if (cvv && !cvv.value) {
                    this.showError(cvv, 'CVV is required');
                    return false;
                }
                if (expiry && !expiry.value) {
                    this.showError(expiry, 'Expiry date is required');
                    return false;
                }
            }
        }
        
        return true;
    }
    
    // Formatting helpers
    formatCardNumber(input) {
        let value = input.value.replace(/\D/g, '');
        value = value.substring(0, 16);
        value = value.replace(/(\d{4})(?=\d)/g, '$1 ');
        input.value = value;
    }
    
    formatExpiryDate(input) {
        let value = input.value.replace(/\D/g, '');
        if (value.length >= 2) {
            value = value.substring(0, 2) + '/' + value.substring(2, 4);
        }
        input.value = value;
    }
    
    // Error display methods
    showError(input, message) {
        this.clearError(input);
        
        // Add error class to input
        input.classList.add('is-invalid', 'error');
        
        // Create error message element
        const errorDiv = document.createElement('div');
        errorDiv.className = 'invalid-feedback error-message';
        errorDiv.textContent = message;
        errorDiv.id = input.name + '_error';
        
        // Insert error message after input
        if (input.parentNode) {
            input.parentNode.insertBefore(errorDiv, input.nextSibling);
        }
        
        // Focus on first error field
        if (!document.querySelector('.is-invalid:focus')) {
            input.focus();
        }
    }
    
    clearError(input) {
        input.classList.remove('is-invalid', 'error');
        const errorMsg = document.getElementById(input.name + '_error');
        if (errorMsg) {
            errorMsg.remove();
        }
    }
    
    clearAllErrors(form) {
        const errorInputs = form.querySelectorAll('.is-invalid, .error');
        errorInputs.forEach(input => {
            input.classList.remove('is-invalid', 'error');
        });
        
        const errorMessages = form.querySelectorAll('.error-message, .invalid-feedback');
        errorMessages.forEach(msg => msg.remove());
    }
    
    // Public methods for manual validation
    validateSpecificField(fieldName) {
        const input = document.querySelector(`[name="${fieldName}"]`);
        if (input) {
            return this.validateField(input);
        }
        return false;
    }
    
    validateFormById(formId) {
        const form = document.getElementById(formId);
        if (form) {
            return this.validateForm(form);
        }
        return false;
    }
}

// Initialize the validator
const driveGoValidator = new DriveGoValidator();

// Export for global use
window.DriveGoValidator = driveGoValidator;