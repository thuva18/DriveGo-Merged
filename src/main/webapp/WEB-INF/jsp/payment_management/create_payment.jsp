<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Payment - Car Rental Service</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#10B981', // Green
                        secondary: '#111827', // Black
                        'green-custom': '#22C55E',
                        'black-custom': '#000000'
                    }
                }
            }
        }
    </script>
    <style>
        body {
            background-color: #121212;
            color: white;
        }
        .error {
            border-color: #EF4444 !important;
            box-shadow: 0 0 0 1px #EF4444;
        }
        .error-message {
            color: #EF4444;
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }
        .success {
            border-color: #10B981 !important;
            box-shadow: 0 0 0 1px #10B981;
        }
        .loading-overlay {
            background: rgba(0, 0, 0, 0.8);
        }
        .card-input {
            background: #1F2937;
            border: 1px solid #374151;
            color: white;
        }
        .card-input:focus {
            border-color: #10B981;
            box-shadow: 0 0 0 2px rgba(16, 185, 129, 0.2);
        }
        .payment-type-card {
            transition: all 0.3s ease;
            cursor: pointer;
        }
        .payment-type-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(16, 185, 129, 0.2);
        }
        .payment-type-card.selected {
            border-color: #10B981;
            background: rgba(16, 185, 129, 0.1);
        }
    </style>
</head>
<body class="min-h-screen bg-gray-900">
    <!-- Header -->
    <header class="bg-black border-b border-green-500 shadow-md">
        <div class="container mx-auto px-4 py-6">
            <div class="flex justify-between items-center">
                <div>
                    <h1 class="text-3xl font-bold text-green-400">Payment Gateway</h1>
                    <p class="text-gray-300 mt-2">Complete your car rental payment</p>
                </div>
                <button id="backButton" class="bg-green-600 hover:bg-green-700 text-white px-6 py-2 rounded-md transition duration-300 flex items-center">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" viewBox="0 0 20 20" fill="currentColor">
                        <path fill-rule="evenodd" d="M9.707 16.707a1 1 0 01-1.414 0l-6-6a1 1 0 010-1.414l6-6a1 1 0 011.414 1.414L5.414 9H17a1 1 0 110 2H5.414l4.293 4.293a1 1 0 010 1.414z" clip-rule="evenodd" />
                    </svg>
                    Back to Bookings
                </button>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="container mx-auto px-4 py-8">
        <!-- Loading Overlay -->
        <div id="loadingOverlay" class="fixed inset-0 loading-overlay flex items-center justify-center z-50 hidden">
            <div class="bg-gray-800 rounded-lg p-8 flex flex-col items-center">
                <div class="animate-spin rounded-full h-16 w-16 border-b-2 border-green-500 mb-4"></div>
                <p class="text-white text-lg">Processing Payment...</p>
            </div>
        </div>

        <!-- Success Alert -->
        <div id="successAlert" class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-6 hidden">
            <div class="flex items-center">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
                <span id="successMessage">Payment created successfully!</span>
            </div>
        </div>

        <!-- Error Alert -->
        <div id="errorAlert" class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-6 hidden">
            <div class="flex items-center">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
                <span id="errorMessage">An error occurred. Please try again.</span>
            </div>
        </div>

        <div class="max-w-4xl mx-auto">
            <!-- Payment Summary Card -->
            <div class="bg-gray-800 border border-gray-700 rounded-lg shadow-lg p-6 mb-8">
                <h2 class="text-2xl font-bold text-green-400 mb-4">Payment Summary</h2>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <p class="text-gray-300"><span class="font-semibold">Booking ID:</span> <span id="summaryBookingId" class="text-green-400">-</span></p>
                        <p class="text-gray-300 mt-2"><span class="font-semibold">Total Amount:</span> <span id="summaryTotalAmount" class="text-green-400 text-xl font-bold">LKR 0</span></p>
                    </div>
                    <div class="text-right">
                        <p class="text-sm text-gray-400">Secure Payment Gateway</p>
                        <div class="flex justify-end mt-2">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                            </svg>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Payment Form -->
            <div class="bg-gray-800 border border-gray-700 rounded-lg shadow-lg p-6">
                <h2 class="text-2xl font-bold text-green-400 mb-6">Payment Details</h2>
                
                <form id="paymentForm" class="space-y-6">
                    <!-- Hidden Fields -->
                    <input type="hidden" id="bookingId" name="bookingId">
                    <input type="hidden" id="totalAmount" name="totalAmount">

                    <!-- User Email -->
                    <div>
                        <label for="userEmail" class="block text-sm font-medium text-gray-300 mb-2">
                            Email Address <span class="text-red-500">*</span>
                        </label>
                        <input type="email" id="userEmail" name="userEmail" required
                               class="w-full px-4 py-3 bg-gray-700 border border-gray-600 rounded-md text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500 transition duration-300"
                               placeholder="Enter your email address">
                        <div id="userEmailError" class="error-message hidden"></div>
                    </div>

                    <!-- Payment Type Selection -->
                    <div>
                        <label class="block text-sm font-medium text-gray-300 mb-4">
                            Payment Method <span class="text-red-500">*</span>
                        </label>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <!-- Card Payment -->
                            <div class="payment-type-card bg-gray-700 border-2 border-gray-600 rounded-lg p-4" data-payment-type="CARD">
                                <div class="flex items-center">
                                    <input type="radio" id="paymentTypeCard" name="paymentType" value="CARD" class="sr-only">
                                    <div class="flex items-center justify-center w-12 h-12 bg-green-600 rounded-full mr-4">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z" />
                                        </svg>
                                    </div>
                                    <div>
                                        <h3 class="text-lg font-semibold text-white">Credit/Debit Card</h3>
                                        <p class="text-sm text-gray-400">Secure card payment</p>
                                    </div>
                                </div>
                            </div>

                            <!-- Cash Payment -->
                            <div class="payment-type-card bg-gray-700 border-2 border-gray-600 rounded-lg p-4" data-payment-type="CASH">
                                <div class="flex items-center">
                                    <input type="radio" id="paymentTypeCash" name="paymentType" value="CASH" class="sr-only">
                                    <div class="flex items-center justify-center w-12 h-12 bg-green-600 rounded-full mr-4">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z" />
                                        </svg>
                                    </div>
                                    <div>
                                        <h3 class="text-lg font-semibold text-white">Cash Payment</h3>
                                        <p class="text-sm text-gray-400">Pay on pickup</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="paymentTypeError" class="error-message hidden"></div>
                    </div>

                    <!-- Credit Card Details (Hidden by default) -->
                    <div id="creditCardSection" class="hidden space-y-4">
                        <h3 class="text-lg font-semibold text-green-400 mb-4">Card Information</h3>
                        
                        <!-- Card Number -->
                        <div>
                            <label for="cardNumber" class="block text-sm font-medium text-gray-300 mb-2">
                                Card Number <span class="text-red-500">*</span>
                            </label>
                            <input type="text" id="cardNumber" name="cardNumber" maxlength="19"
                                   class="card-input w-full px-4 py-3 rounded-md focus:outline-none transition duration-300"
                                   placeholder="1234 5678 9012 3456">
                            <div id="cardNumberError" class="error-message hidden"></div>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <!-- Expiry Date -->
                            <div>
                                <label for="expiryDate" class="block text-sm font-medium text-gray-300 mb-2">
                                    Expiry Date <span class="text-red-500">*</span>
                                </label>
                                <input type="text" id="expiryDate" name="expiryDate" maxlength="5"
                                       class="card-input w-full px-4 py-3 rounded-md focus:outline-none transition duration-300"
                                       placeholder="MM/YY">
                                <div id="expiryDateError" class="error-message hidden"></div>
                            </div>

                            <!-- CVV -->
                            <div>
                                <label for="cvv" class="block text-sm font-medium text-gray-300 mb-2">
                                    CVV <span class="text-red-500">*</span>
                                </label>
                                <input type="text" id="cvv" name="cvv" maxlength="4"
                                       class="card-input w-full px-4 py-3 rounded-md focus:outline-none transition duration-300"
                                       placeholder="123">
                                <div id="cvvError" class="error-message hidden"></div>
                            </div>
                        </div>

                        <!-- Cardholder Name -->
                        <div>
                            <label for="cardholderName" class="block text-sm font-medium text-gray-300 mb-2">
                                Cardholder Name <span class="text-red-500">*</span>
                            </label>
                            <input type="text" id="cardholderName" name="cardholderName"
                                   class="card-input w-full px-4 py-3 rounded-md focus:outline-none transition duration-300"
                                   placeholder="John Doe">
                            <div id="cardholderNameError" class="error-message hidden"></div>
                        </div>
                    </div>

                    <!-- Submit Button -->
                    <div class="flex justify-end pt-6">
                        <button type="submit" id="submitButton" 
                                class="bg-green-600 hover:bg-green-700 text-white font-bold py-3 px-8 rounded-md transition duration-300 flex items-center disabled:opacity-50 disabled:cursor-not-allowed">
                            <span id="submitButtonText">Process Payment</span>
                            <div id="submitSpinner" class="hidden ml-2">
                                <svg class="animate-spin h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                                    <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                                </svg>
                            </div>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-black border-t border-green-500 mt-12 py-6">
        <div class="container mx-auto px-4 text-center text-gray-400">
            <p>&copy; 2024 Car Rental Service. All rights reserved.</p>
            <p class="text-sm mt-2">Secure payments powered by advanced encryption</p>
        </div>
    </footer>

    <script src="/js/payment_management/create_payment.js"></script>
</body>
</html>