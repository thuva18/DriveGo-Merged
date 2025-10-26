<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book a Car</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#10B981', // Green
                        secondary: '#111827', // Black
                    }
                }
            }
        }
    </script>
    <style>
        .error {
            border-color: #EF4444;
        }
        .error-message {
            color: #EF4444;
            font-size: 0.875rem;
        }
    </style>
</head>
<body class="bg-gray-100 min-h-screen">
    <div class="bg-secondary text-white p-4 shadow-md">
        <div class="container mx-auto flex justify-between items-center">
            <h1 class="text-2xl font-bold">Car Booking</h1>
            <button id="backButton" class="bg-primary hover:bg-green-600 text-white px-4 py-2 rounded-md transition duration-300 flex items-center">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-1" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M9.707 14.707a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 1.414L7.414 9H15a1 1 0 110 2H7.414l2.293 2.293a1 1 0 010 1.414z" clip-rule="evenodd" />
                </svg>
                Back to Cars
            </button>
        </div>
    </div>

    <div class="container mx-auto py-8 px-4">
        <div class="bg-white rounded-lg shadow-md p-6 max-w-2xl mx-auto">
            <h2 class="text-2xl font-bold mb-6 text-secondary">Book Your Car</h2>
            
            <!-- Error Alert -->
            <div id="errorAlert" class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4 hidden">
                <div class="flex">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                    <span id="errorMessage"></span>
                </div>
            </div>
            
            <!-- Booking Form -->
            <form id="bookingForm">
                <input type="hidden" id="carId" name="carId">
                
                <div class="mb-6 p-4 bg-gray-50 rounded-md">
                    <h3 class="text-lg font-semibold mb-2 text-secondary">Pricing Details</h3>
                    <div class="flex justify-between items-center mb-2">
                        <span>Price per day:</span>
                        <span class="font-bold">LKR <span id="carPrice">0</span></span>
                    </div>
                    <div class="mb-4">
                        <label for="bookingDays" class="block text-gray-700 mb-1">Number of Days:</label>
                        <input type="number" id="bookingDays" name="bookingDays" min="1" class="w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary">
                        <div class="error-message"></div>
                    </div>
                    <div class="flex justify-between items-center font-bold text-lg">
                        <span>Total Price:</span>
                        <span>LKR <span id="totalPrice">0</span></span>
                    </div>
                </div>
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
                    <div>
                        <label for="contactPersonName" class="block text-gray-700 mb-1">Contact Person Name:</label>
                        <input type="text" id="contactPersonName" name="contactPersonName" class="w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary">
                        <div class="error-message"></div>
                    </div>
                    <div>
                        <label for="contactNumber" class="block text-gray-700 mb-1">Contact Number:</label>
                        <input type="text" id="contactNumber" name="contactNumber" class="w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary">
                        <div class="error-message"></div>
                    </div>
                </div>
                
                <div class="mb-4">
                    <label for="bookedEmail" class="block text-gray-700 mb-1">Email:</label>
                    <input type="email" id="bookedEmail" name="bookedEmail" class="w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary">
                    <div class="error-message"></div>
                </div>
                
                <div class="mb-4">
                    <label for="bookingDate" class="block text-gray-700 mb-1">Booking Date:</label>
                    <input type="date" id="bookingDate" name="bookingDate" class="w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary">
                    <div class="error-message"></div>
                </div>
                
                <div class="mb-6">
                    <label for="additionalNotes" class="block text-gray-700 mb-1">Additional Notes:</label>
                    <textarea id="additionalNotes" name="additionalNotes" rows="3" class="w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary"></textarea>
                </div>
                
                <div class="flex justify-end">
                    <button type="submit" id="submitButton" class="bg-primary hover:bg-green-600 text-white px-6 py-2 rounded-md transition duration-300 flex items-center">
                        <span>Book Now</span>
                        <div id="loadingSpinner" class="hidden ml-2">
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
    
    <footer class="bg-secondary text-white py-4 mt-8">
        <div class="container mx-auto text-center">
            <p>&copy; 2023 Car Rental Service. All rights reserved.</p>
        </div>
    </footer>
    
    <script src="/js/booking_management/create_booking.js"></script>
</body>
</html>