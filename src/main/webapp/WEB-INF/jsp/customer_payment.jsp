<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complete Payment - DriveGo</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #ffffff;
            color: #000000;
            min-height: 100vh;
        }

        .container {
            max-width: 1000px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        .page-header {
            text-align: center;
            color: #000000;
            margin-bottom: 2rem;
            padding: 2rem 0;
        }

        .page-header h1 {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            color: #000000;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .page-header h1 i {
            color: #0cc23c;
        }

        .page-header p {
            color: #64748b;
            font-size: 1.1rem;
        }

        .vehicle-info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-top: 1.5rem;
        }

        .vehicle-info-item {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .vehicle-info-item i {
            color: #0cc23c;
            font-size: 1.2rem;
        }

        .vehicle-info-label {
            color: rgba(255,255,255,0.7);
            font-size: 0.9rem;
        }

        .vehicle-info-value {
            color: white;
            font-size: 1.1rem;
            font-weight: 500;
        }

        .booking-content {
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .booking-header {
            background: linear-gradient(135deg, #000000 0%, #1a1a1a 100%);
            padding: 2rem;
            color: white;
            border-bottom: 3px solid #0cc23c;
        }

        .booking-header h2 {
            color: white;
            font-size: 1.8rem;
            margin-bottom: 1rem;
        }

        .content-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            padding: 2rem;
        }

        .card {
            background: white;
            border-radius: 0.75rem;
            padding: 0;
        }

        .card h2 {
            color: #15803d;
            font-size: 1.3rem;
            margin-bottom: 1.5rem;
            padding: 1.5rem;
            background: #f0fdf4;
            margin: 0;
            border-radius: 0.75rem 0.75rem 0 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .card-content {
            padding: 1.5rem;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 1rem 0;
            border-bottom: 1px solid #f1f5f9;
        }

        .detail-row:last-child {
            border-bottom: none;
        }

        .detail-label {
            color: #64748b;
            font-weight: 600;
        }

        .detail-value {
            color: #1e293b;
            font-weight: 500;
        }

        .total-amount {
            background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%);
            padding: 1.5rem;
            border-radius: 0.75rem;
            margin: 1.5rem 0;
            text-align: center;
        }

        .total-amount .label {
            color: #64748b;
            font-size: 0.875rem;
            margin-bottom: 0.5rem;
        }

        .total-amount .amount {
            color: #15803d;
            font-size: 2.5rem;
            font-weight: 700;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            color: #374151;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .payment-method {
            border: 2px solid #e5e7eb;
            border-radius: 0.75rem;
            padding: 1rem;
            cursor: pointer;
            transition: all 0.3s;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .payment-method:hover {
            border-color: #16a34a;
            background: #f0fdf4;
        }

        .payment-method input[type="radio"] {
            width: 1.25rem;
            height: 1.25rem;
            accent-color: #16a34a;
        }

        .payment-method input[type="radio"]:checked ~ .method-info {
            color: #15803d;
        }

        .payment-method input[type="radio"]:checked {
            border-color: #16a34a;
        }

        .method-info {
            flex: 1;
        }

        .method-name {
            font-weight: 600;
            font-size: 1.1rem;
            color: #1e293b;
            margin-bottom: 0.25rem;
        }

        .method-desc {
            font-size: 0.875rem;
            color: #64748b;
        }

        .method-icon {
            font-size: 2rem;
            color: #16a34a;
        }

        .payment-details {
            margin-top: 1rem;
            padding: 1.5rem;
            background: #f8fafb;
            border-radius: 0.75rem;
            border: 2px solid #16a34a;
            display: none;
        }

        .payment-details.active {
            display: block;
            animation: slideDown 0.3s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-input {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 2px solid #e5e7eb;
            border-radius: 0.5rem;
            font-size: 1rem;
            transition: all 0.3s;
        }

        .form-input:focus {
            outline: none;
            border-color: #16a34a;
            background: #f0fdf4;
        }

        .input-row {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 1rem;
        }

        .bank-details {
            background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%);
            padding: 1.5rem;
            border-radius: 0.75rem;
            margin-bottom: 1.5rem;
        }

        .bank-details h4 {
            color: #15803d;
            margin-bottom: 1rem;
            font-size: 1.1rem;
        }

        .bank-info-row {
            display: flex;
            justify-content: space-between;
            padding: 0.75rem 0;
            border-bottom: 1px solid rgba(22, 163, 74, 0.2);
        }

        .bank-info-row:last-child {
            border-bottom: none;
        }

        .bank-label {
            color: #64748b;
            font-weight: 600;
        }

        .bank-value {
            color: #1e293b;
            font-weight: 600;
        }

        .file-upload {
            border: 2px dashed #16a34a;
            border-radius: 0.75rem;
            padding: 2rem;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            background: white;
        }

        .file-upload:hover {
            background: #f0fdf4;
            border-color: #15803d;
        }

        .file-upload i {
            font-size: 3rem;
            color: #16a34a;
            margin-bottom: 1rem;
        }

        .file-upload input[type="file"] {
            display: none;
        }

        .file-name {
            margin-top: 1rem;
            color: #15803d;
            font-weight: 600;
        }

        .btn {
            width: 100%;
            padding: 1rem;
            border: none;
            border-radius: 0.75rem;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .btn-primary {
            background: #16a34a;
            color: white;
        }

        .btn-primary:hover {
            background: #15803d;
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(22, 163, 74, 0.3);
        }

        .btn-secondary {
            background: #64748b;
            color: white;
            margin-top: 1rem;
        }

        .btn-secondary:hover {
            background: #475569;
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
            background: #dcfce7;
            color: #166534;
            border-left: 4px solid #16a34a;
        }

        .alert-error {
            background: #fee2e2;
            color: #991b1b;
            border-left: 4px solid #dc2626;
        }

        .vehicle-info {
            background: #f8fafb;
            padding: 1rem;
            border-radius: 0.75rem;
            margin-bottom: 1rem;
        }

        .vehicle-name {
            font-weight: 700;
            color: #15803d;
            font-size: 1.25rem;
        }

        @media (max-width: 768px) {
            .content-grid {
                grid-template-columns: 1fr;
            }

            body {
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="page-header">
            <h1><i class="fas fa-credit-card"></i> Complete Your Payment</h1>
            <p>Booking Confirmation #BK-${booking.id}</p>
        </div>

        <!-- Flash Messages -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                ${successMessage}
            </div>
        </c:if>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                ${errorMessage}
            </div>
        </c:if>

        <div class="booking-content">
            <!-- Black Header with Booking Details -->
            <div class="booking-header">
                <h2><i class="fas fa-receipt"></i> Booking Summary</h2>
                <div class="vehicle-info-grid">
                    <div class="vehicle-info-item">
                        <i class="fas fa-car"></i>
                        <div>
                            <div class="vehicle-info-label">Vehicle</div>
                            <div class="vehicle-info-value">${vehicle.model}</div>
                        </div>
                    </div>
                    <div class="vehicle-info-item">
                        <i class="fas fa-id-card"></i>
                        <div>
                            <div class="vehicle-info-label">Registration</div>
                            <div class="vehicle-info-value">${vehicle.regNo}</div>
                        </div>
                    </div>
                    <div class="vehicle-info-item">
                        <i class="fas fa-calendar-alt"></i>
                        <div>
                            <div class="vehicle-info-label">Booking Date</div>
                            <div class="vehicle-info-value">${booking.bookingDate}</div>
                        </div>
                    </div>
                    <div class="vehicle-info-item">
                        <i class="fas fa-clock"></i>
                        <div>
                            <div class="vehicle-info-label">Duration</div>
                            <div class="vehicle-info-value">${days} Day(s)</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="content-grid">
                <!-- Payment Amount Summary -->
                <div class="card">
                    <h2><i class="fas fa-file-invoice-dollar"></i> Payment Details</h2>
                    <div class="card-content">                <div class="detail-row">
                    <div class="detail-label">Customer:</div>
                    <div class="detail-value">${booking.contactPersonName}</div>
                </div>

                <div class="detail-row">
                    <div class="detail-label">Pickup Date:</div>
                    <div class="detail-value">
                        <fmt:formatDate value="${booking.pickupDate}" pattern="EEEE, MMM dd, yyyy"/>
                    </div>
                </div>

                <div class="detail-row">
                    <div class="detail-label">Return Date:</div>
                    <div class="detail-value">
                        <fmt:formatDate value="${booking.returnDate}" pattern="EEEE, MMM dd, yyyy"/>
                        <div class="detail-row">
                            <div class="detail-label">Contact Person:</div>
                            <div class="detail-value">${booking.contactPersonName}</div>
                        </div>

                        <div class="detail-row">
                            <div class="detail-label">Pickup Location:</div>
                            <div class="detail-value">${booking.pickupLocation}</div>
                        </div>

                        <div class="detail-row">
                            <div class="detail-label">Duration:</div>
                            <div class="detail-value">${days} day(s)</div>
                        </div>

                        <div class="detail-row">
                            <div class="detail-label">Daily Rate:</div>
                            <div class="detail-value">LKR <fmt:formatNumber value="${dailyRate}" type="number" minFractionDigits="2"/></div>
                        </div>

                        <div class="total-amount">
                            <div class="label">Total Amount</div>
                            <div class="amount">LKR <fmt:formatNumber value="${totalAmount}" type="number" minFractionDigits="2"/></div>
                        </div>
                    </div>
                </div>

                <!-- Payment Form -->
                <div class="card">
                    <h2><i class="fas fa-wallet"></i> Payment Method</h2>
                    <div class="card-content">
                        <form method="POST" action="/customer/process-payment" enctype="multipart/form-data" id="paymentForm">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <input type="hidden" name="bookingId" value="${booking.id}"/>
                            <input type="hidden" name="amount" value="${totalAmount}"/>

                            <div class="form-group">
                                <label class="form-label">Select Payment Method:</label>

                                <label class="payment-method" onclick="selectPaymentMethod('CASH')">
                                    <input type="radio" name="paymentMethod" value="CASH" id="cashRadio" required>
                                    <div class="method-icon">
                                        <i class="fas fa-money-bill-wave"></i>
                                    </div>
                                    <div class="method-info">
                                        <div class="method-name">Cash</div>
                                        <div class="method-desc">Pay with cash at pickup</div>
                                    </div>
                                </label>

                                <label class="payment-method" onclick="selectPaymentMethod('CREDIT_CARD')">
                                    <input type="radio" name="paymentMethod" value="CREDIT_CARD" id="creditRadio" required>
                                    <div class="method-icon">
                                        <i class="fas fa-credit-card"></i>
                                    </div>
                                    <div class="method-info">
                                        <div class="method-name">Credit Card</div>
                                        <div class="method-desc">Visa, MasterCard, Amex</div>
                                    </div>
                                </label>

                                <!-- Credit Card Details Form -->
                                <div id="creditCardDetails" class="payment-details">
                                    <div class="form-group">
                                        <label class="form-label">Card Number <span class="required">*</span></label>
                                        <input type="text" name="cardNumber" class="form-input" 
                                               placeholder="1234 5678 9012 3456" 
                                               maxlength="19" 
                                               pattern="\d{4}\s?\d{4}\s?\d{4}\s?\d{4}"
                                               title="Please enter a valid 16-digit card number"
                                               autocomplete="cc-number">
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Cardholder Name <span class="required">*</span></label>
                                        <input type="text" name="cardholderName" class="form-input" 
                                               placeholder="Name on card"
                                               pattern="[a-zA-Z\s]+"
                                               title="Please enter the name as it appears on the card"
                                               autocomplete="cc-name">
                                    </div>
                                    <div class="input-row">
                                        <div class="form-group">
                                            <label class="form-label">Expiry Date <span class="required">*</span></label>
                                            <input type="text" name="expiryDate" class="form-input" 
                                                   placeholder="MM/YY" 
                                                   maxlength="5" 
                                                   pattern="\d{2}/\d{2}"
                                                   title="Please enter expiry date in MM/YY format"
                                                   autocomplete="cc-exp">
                                        </div>
                                        <div class="form-group">
                                            <label class="form-label">CVV <span class="required">*</span></label>
                                            <input type="text" name="cvv" class="form-input" 
                                                   placeholder="123" 
                                                   maxlength="4" 
                                                   pattern="\d{3,4}"
                                                   title="Please enter the 3 or 4 digit security code"
                                                   autocomplete="cc-csc">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label style="display: flex; align-items: center; gap: 0.5rem; cursor: pointer;">
                                            <input type="checkbox" name="saveCard" value="true" style="width: 1.2rem; height: 1.2rem; accent-color: #16a34a;">
                                            <span style="color: #374151; font-weight: 600;">Save this card for future payments</span>
                                        </label>
                                    </div>
                                </div>

                                <label class="payment-method" onclick="selectPaymentMethod('DEBIT_CARD')">
                                    <input type="radio" name="paymentMethod" value="DEBIT_CARD" id="debitRadio" required>
                                    <div class="method-icon">
                                        <i class="fas fa-credit-card"></i>
                                    </div>
                                    <div class="method-info">
                                        <div class="method-name">Debit Card</div>
                                        <div class="method-desc">Direct debit from your account</div>
                                    </div>
                                </label>

                                <!-- Debit Card Details Form -->
                                <div id="debitCardDetails" class="payment-details">
                                    <div class="form-group">
                                        <label class="form-label">Card Number <span class="required">*</span></label>
                                        <input type="text" name="debitCardNumber" class="form-input" 
                                               placeholder="1234 5678 9012 3456" 
                                               maxlength="19" 
                                               pattern="\d{4}\s?\d{4}\s?\d{4}\s?\d{4}"
                                               title="Please enter a valid 16-digit card number"
                                               autocomplete="cc-number">
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Cardholder Name <span class="required">*</span></label>
                                        <input type="text" name="debitCardholderName" class="form-input" 
                                               placeholder="Name on card"
                                               pattern="[a-zA-Z\s]+"
                                               title="Please enter the name as it appears on the card"
                                               autocomplete="cc-name">
                                    </div>
                                    <div class="input-row">
                                        <div class="form-group">
                                            <label class="form-label">Expiry Date <span class="required">*</span></label>
                                            <input type="text" name="debitExpiryDate" class="form-input" 
                                                   placeholder="MM/YY" 
                                                   maxlength="5" 
                                                   pattern="\d{2}/\d{2}"
                                                   title="Please enter expiry date in MM/YY format"
                                                   autocomplete="cc-exp">
                                        </div>
                                        <div class="form-group">
                                            <label class="form-label">CVV <span class="required">*</span></label>
                                            <input type="text" name="debitCvv" class="form-input" 
                                                   placeholder="123" 
                                                   maxlength="4" 
                                                   pattern="\d{3,4}"
                                                   title="Please enter the 3 or 4 digit security code"
                                                   autocomplete="cc-csc">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label style="display: flex; align-items: center; gap: 0.5rem; cursor: pointer;">
                                            <input type="checkbox" name="saveDebitCard" value="true" style="width: 1.2rem; height: 1.2rem; accent-color: #16a34a;">
                                            <span style="color: #374151; font-weight: 600;">Save this card for future payments</span>
                                        </label>
                                    </div>
                                </div>

                                <label class="payment-method" onclick="selectPaymentMethod('BANK_TRANSFER')">
                                    <input type="radio" name="paymentMethod" value="BANK_TRANSFER" id="bankRadio" required>
                                    <div class="method-icon">
                                        <i class="fas fa-university"></i>
                                    </div>
                                    <div class="method-info">
                                        <div class="method-name">Bank Transfer</div>
                                        <div class="method-desc">Transfer directly to our account</div>
                                    </div>
                                </label>

                                <!-- Bank Transfer Details -->
                                <div id="bankTransferDetails" class="payment-details">
                                    <div class="bank-details">
                                        <h4><i class="fas fa-building-columns"></i> Our Bank Details</h4>
                                        <div class="bank-info-row">
                                            <span class="bank-label">Bank Name:</span>
                                            <span class="bank-value">Commercial Bank of Ceylon</span>
                                        </div>
                                        <div class="bank-info-row">
                                            <span class="bank-label">Account Name:</span>
                                            <span class="bank-value">DriveGo Car Rentals (Pvt) Ltd</span>
                                        </div>
                                        <div class="bank-info-row">
                                            <span class="bank-label">Account Number:</span>
                                            <span class="bank-value">8001234567890</span>
                                        </div>
                                        <div class="bank-info-row">
                                            <span class="bank-label">Branch:</span>
                                            <span class="bank-value">Colombo Main Branch</span>
                                        </div>
                                        <div class="bank-info-row">
                                            <span class="bank-label">SWIFT Code:</span>
                                            <span class="bank-value">CCEYLKLX</span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label">Upload Payment Receipt <span style="color: #dc2626;">*</span></label>
                                        <div class="file-upload" onclick="document.getElementById('paymentReceipt').click()">
                                            <input type="file" name="paymentReceipt" id="paymentReceipt" accept="image/*,.pdf" onchange="displayFileName(this)">
                                            <i class="fas fa-cloud-upload-alt"></i>
                                            <p style="color: #64748b; margin: 0.5rem 0;">Click to upload payment receipt</p>
                                            <p style="color: #94a3b8; font-size: 0.875rem;">Accepted: JPG, PNG, PDF (Max 5MB)</p>
                                            <div id="fileName" class="file-name"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-check-circle"></i>
                                Confirm Payment
                            </button>

                            <a href="/customer/my-bookings" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i>
                                Cancel
                            </a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Show/hide payment details based on selected method
        function selectPaymentMethod(method) {
            // Hide all payment details
            document.querySelectorAll('.payment-details').forEach(detail => {
                detail.classList.remove('active');
            });

            // Reset all payment method styles
            document.querySelectorAll('.payment-method').forEach(pm => {
                pm.style.borderColor = '#e5e7eb';
                pm.style.background = 'white';
            });

            // Show selected payment details
            if (method === 'CREDIT_CARD') {
                document.getElementById('creditCardDetails').classList.add('active');
                document.getElementById('creditRadio').checked = true;
                document.getElementById('creditRadio').closest('.payment-method').style.borderColor = '#16a34a';
                document.getElementById('creditRadio').closest('.payment-method').style.background = '#f0fdf4';
            } else if (method === 'DEBIT_CARD') {
                document.getElementById('debitCardDetails').classList.add('active');
                document.getElementById('debitRadio').checked = true;
                document.getElementById('debitRadio').closest('.payment-method').style.borderColor = '#16a34a';
                document.getElementById('debitRadio').closest('.payment-method').style.background = '#f0fdf4';
            } else if (method === 'BANK_TRANSFER') {
                document.getElementById('bankTransferDetails').classList.add('active');
                document.getElementById('bankRadio').checked = true;
                document.getElementById('bankRadio').closest('.payment-method').style.borderColor = '#16a34a';
                document.getElementById('bankRadio').closest('.payment-method').style.background = '#f0fdf4';
            } else if (method === 'CASH') {
                document.getElementById('cashRadio').checked = true;
                document.getElementById('cashRadio').closest('.payment-method').style.borderColor = '#16a34a';
                document.getElementById('cashRadio').closest('.payment-method').style.background = '#f0fdf4';
            }
        }

        // Display selected file name
        function displayFileName(input) {
            const fileName = input.files[0]?.name;
            const fileNameDiv = document.getElementById('fileName');
            if (fileName) {
                fileNameDiv.textContent = '✓ ' + fileName;
                fileNameDiv.style.display = 'block';
            } else {
                fileNameDiv.style.display = 'none';
            }
        }

        // Format card number input with spaces
        document.querySelectorAll('input[name="cardNumber"], input[name="debitCardNumber"]').forEach(input => {
            input.addEventListener('input', function(e) {
                let value = e.target.value.replace(/\s/g, '');
                let formattedValue = value.match(/.{1,4}/g)?.join(' ') || value;
                e.target.value = formattedValue;
            });
        });

        // Format expiry date input
        document.querySelectorAll('input[name="expiryDate"], input[name="debitExpiryDate"]').forEach(input => {
            input.addEventListener('input', function(e) {
                let value = e.target.value.replace(/\D/g, '');
                if (value.length >= 2) {
                    value = value.slice(0, 2) + '/' + value.slice(2, 4);
                }
                e.target.value = value;
            });
        });

        // Only allow numbers in CVV
        document.querySelectorAll('input[name="cvv"], input[name="debitCvv"]').forEach(input => {
            input.addEventListener('input', function(e) {
                e.target.value = e.target.value.replace(/\D/g, '');
            });
        });

        // Form validation before submit
        document.getElementById('paymentForm').addEventListener('submit', function(e) {
            const selectedMethod = document.querySelector('input[name="paymentMethod"]:checked')?.value;
            
            if (selectedMethod === 'CREDIT_CARD') {
                const cardNumber = document.querySelector('input[name="cardNumber"]').value;
                const cardholderName = document.querySelector('input[name="cardholderName"]').value;
                const expiryDate = document.querySelector('input[name="expiryDate"]').value;
                const cvv = document.querySelector('input[name="cvv"]').value;
                
                if (!cardNumber || !cardholderName || !expiryDate || !cvv) {
                    e.preventDefault();
                    alert('Please fill in all credit card details');
                    return false;
                }
            } else if (selectedMethod === 'DEBIT_CARD') {
                const cardNumber = document.querySelector('input[name="debitCardNumber"]').value;
                const cardholderName = document.querySelector('input[name="debitCardholderName"]').value;
                const expiryDate = document.querySelector('input[name="debitExpiryDate"]').value;
                const cvv = document.querySelector('input[name="debitCvv"]').value;
                
                if (!cardNumber || !cardholderName || !expiryDate || !cvv) {
                    e.preventDefault();
                    alert('Please fill in all debit card details');
                    return false;
                }
            } else if (selectedMethod === 'BANK_TRANSFER') {
                const receipt = document.getElementById('paymentReceipt').files[0];
                
                if (!receipt) {
                    e.preventDefault();
                    alert('Please upload payment receipt for bank transfer');
                    return false;
                }
                
                // Check file size (5MB max)
                if (receipt.size > 5 * 1024 * 1024) {
                    e.preventDefault();
                    alert('File size should not exceed 5MB');
                    return false;
                }
            }
        });
    </script>
</body>
</html>
