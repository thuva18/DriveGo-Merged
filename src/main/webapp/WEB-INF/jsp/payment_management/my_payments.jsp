<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Payments - Car Rental Service</title>
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
        .payment-card {
            transition: all 0.3s ease;
            cursor: pointer;
        }
        .payment-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(16, 185, 129, 0.2);
        }
        .status-pending {
            background: rgba(251, 191, 36, 0.2);
            color: #F59E0B;
            border-color: #F59E0B;
        }
        .status-completed {
            background: rgba(16, 185, 129, 0.2);
            color: #10B981;
            border-color: #10B981;
        }
        .status-failed {
            background: rgba(239, 68, 68, 0.2);
            color: #EF4444;
            border-color: #EF4444;
        }
        .status-cancelled {
            background: rgba(107, 114, 128, 0.2);
            color: #6B7280;
            border-color: #6B7280;
        }
        .loading-skeleton {
            background: linear-gradient(90deg, #374151 25%, #4B5563 50%, #374151 75%);
            background-size: 200% 100%;
            animation: loading 1.5s infinite;
        }
        @keyframes loading {
            0% { background-position: 200% 0; }
            100% { background-position: -200% 0; }
        }
        .search-input {
            background: #1F2937;
            border: 1px solid #374151;
            color: white;
        }
        .search-input:focus {
            border-color: #10B981;
            box-shadow: 0 0 0 2px rgba(16, 185, 129, 0.2);
        }
        .filter-select {
            background: #1F2937;
            border: 1px solid #374151;
            color: white;
        }
        .filter-select:focus {
            border-color: #10B981;
            box-shadow: 0 0 0 2px rgba(16, 185, 129, 0.2);
        }
    </style>
</head>
<body class="min-h-screen bg-gray-900">
    <!-- Header -->
    <header class="bg-black border-b border-green-500 shadow-md">
        <div class="container mx-auto px-4 py-6">
            <div class="flex justify-between items-center">
                <div>
                    <h1 class="text-3xl font-bold text-green-400">My Payments</h1>
                    <p class="text-gray-300 mt-2">View and manage your payment history</p>
                </div>
                <button id="backButton" class="bg-green-600 hover:bg-green-700 text-white px-6 py-2 rounded-md transition duration-300 flex items-center">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" viewBox="0 0 20 20" fill="currentColor">
                        <path fill-rule="evenodd" d="M9.707 16.707a1 1 0 01-1.414 0l-6-6a1 1 0 010-1.414l6-6a1 1 0 011.414 1.414L5.414 9H17a1 1 0 110 2H5.414l4.293 4.293a1 1 0 010 1.414z" clip-rule="evenodd" />
                    </svg>
                    Back
                </button>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="container mx-auto px-4 py-8">
        <!-- Loading Overlay -->
        <div id="loadingOverlay" class="fixed inset-0 bg-black bg-opacity-80 flex items-center justify-center z-50 hidden">
            <div class="bg-gray-800 rounded-lg p-8 flex flex-col items-center">
                <div class="animate-spin rounded-full h-16 w-16 border-b-2 border-green-500 mb-4"></div>
                <p class="text-white text-lg">Loading Payments...</p>
            </div>
        </div>

        <!-- Error Alert -->
        <div id="errorAlert" class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-6 hidden">
            <div class="flex items-center">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
                <span id="errorMessage">An error occurred while loading payments.</span>
            </div>
        </div>

        <!-- Search and Filter Section -->
        <div class="bg-gray-800 border border-gray-700 rounded-lg shadow-lg p-6 mb-8">
            <h2 class="text-xl font-bold text-green-400 mb-4">Search & Filter</h2>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
                <!-- Search by Email -->
                <div>
                    <label for="searchEmail" class="block text-sm font-medium text-gray-300 mb-2">Search by Email</label>
                    <input type="text" id="searchEmail" placeholder="Enter email address"
                           class="search-input w-full px-4 py-2 rounded-md focus:outline-none transition duration-300">
                </div>

                <!-- Filter by Status -->
                <div>
                    <label for="filterStatus" class="block text-sm font-medium text-gray-300 mb-2">Filter by Status</label>
                    <select id="filterStatus" class="filter-select w-full px-4 py-2 rounded-md focus:outline-none transition duration-300">
                        <option value="">All Statuses</option>
                        <option value="PENDING">Pending</option>
                        <option value="COMPLETED">Completed</option>
                        <option value="FAILED">Failed</option>
                        <option value="CANCELLED">Cancelled</option>
                    </select>
                </div>

                <!-- Filter by Payment Type -->
                <div>
                    <label for="filterPaymentType" class="block text-sm font-medium text-gray-300 mb-2">Filter by Type</label>
                    <select id="filterPaymentType" class="filter-select w-full px-4 py-2 rounded-md focus:outline-none transition duration-300">
                        <option value="">All Types</option>
                        <option value="CARD">Card Payment</option>
                        <option value="CASH">Cash Payment</option>
                    </select>
                </div>

                <!-- Search Button -->
                <div class="flex items-end">
                    <button id="searchButton" class="bg-green-600 hover:bg-green-700 text-white px-6 py-2 rounded-md transition duration-300 w-full">
                        Search
                    </button>
                </div>
            </div>
            
            <!-- Clear Filters -->
            <div class="mt-4">
                <button id="clearFiltersButton" class="text-green-400 hover:text-green-300 text-sm underline">
                    Clear all filters
                </button>
            </div>
        </div>

        <!-- Payment Statistics -->
        <div id="paymentStats" class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8 hidden">
            <div class="bg-gray-800 border border-gray-700 rounded-lg p-6 text-center">
                <h3 class="text-lg font-semibold text-gray-300 mb-2">Total Payments</h3>
                <p id="totalPayments" class="text-3xl font-bold text-green-400">0</p>
            </div>
            <div class="bg-gray-800 border border-gray-700 rounded-lg p-6 text-center">
                <h3 class="text-lg font-semibold text-gray-300 mb-2">Completed</h3>
                <p id="completedPayments" class="text-3xl font-bold text-green-400">0</p>
            </div>
            <div class="bg-gray-800 border border-gray-700 rounded-lg p-6 text-center">
                <h3 class="text-lg font-semibold text-gray-300 mb-2">Pending</h3>
                <p id="pendingPayments" class="text-3xl font-bold text-yellow-400">0</p>
            </div>
            <div class="bg-gray-800 border border-gray-700 rounded-lg p-6 text-center">
                <h3 class="text-lg font-semibold text-gray-300 mb-2">Total Amount</h3>
                <p id="totalAmount" class="text-3xl font-bold text-green-400">LKR 0</p>
            </div>
        </div>

        <!-- Payments Container -->
        <div class="mb-6">
            <div class="flex justify-between items-center mb-4">
                <h2 class="text-2xl font-bold text-green-400">Payment History</h2>
                <div class="text-gray-300">
                    <span id="paymentCount">0</span> payments found
                </div>
            </div>
        </div>

        <!-- Loading Skeletons -->
        <div id="loadingSkeletons" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 hidden">
            <div class="bg-gray-800 border border-gray-700 rounded-lg p-6">
                <div class="loading-skeleton h-4 w-3/4 mb-4 rounded"></div>
                <div class="loading-skeleton h-3 w-1/2 mb-2 rounded"></div>
                <div class="loading-skeleton h-3 w-2/3 mb-2 rounded"></div>
                <div class="loading-skeleton h-8 w-1/3 mt-4 rounded"></div>
            </div>
            <div class="bg-gray-800 border border-gray-700 rounded-lg p-6">
                <div class="loading-skeleton h-4 w-3/4 mb-4 rounded"></div>
                <div class="loading-skeleton h-3 w-1/2 mb-2 rounded"></div>
                <div class="loading-skeleton h-3 w-2/3 mb-2 rounded"></div>
                <div class="loading-skeleton h-8 w-1/3 mt-4 rounded"></div>
            </div>
            <div class="bg-gray-800 border border-gray-700 rounded-lg p-6">
                <div class="loading-skeleton h-4 w-3/4 mb-4 rounded"></div>
                <div class="loading-skeleton h-3 w-1/2 mb-2 rounded"></div>
                <div class="loading-skeleton h-3 w-2/3 mb-2 rounded"></div>
                <div class="loading-skeleton h-8 w-1/3 mt-4 rounded"></div>
            </div>
        </div>

        <!-- Payments Grid -->
        <div id="paymentsContainer" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <!-- Payment cards will be dynamically inserted here -->
        </div>

        <!-- No Payments Message -->
        <div id="noPaymentsMessage" class="text-center py-12 hidden">
            <div class="bg-gray-800 border border-gray-700 rounded-lg p-8">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-16 w-16 text-gray-500 mx-auto mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                </svg>
                <h3 class="text-xl font-semibold text-gray-300 mb-2">No Payments Found</h3>
                <p class="text-gray-400">You haven't made any payments yet or no payments match your search criteria.</p>
                <button onclick="window.location.href='/'" class="mt-4 bg-green-600 hover:bg-green-700 text-white px-6 py-2 rounded-md transition duration-300">
                    Browse Cars
                </button>
            </div>
        </div>

        <!-- Pagination -->
        <div id="paginationContainer" class="flex justify-center mt-8 hidden">
            <nav class="flex items-center space-x-2">
                <button id="prevPageButton" class="px-4 py-2 bg-gray-700 text-gray-300 rounded-md hover:bg-gray-600 transition duration-300 disabled:opacity-50 disabled:cursor-not-allowed">
                    Previous
                </button>
                <div id="pageNumbers" class="flex space-x-2">
                    <!-- Page numbers will be dynamically inserted here -->
                </div>
                <button id="nextPageButton" class="px-4 py-2 bg-gray-700 text-gray-300 rounded-md hover:bg-gray-600 transition duration-300 disabled:opacity-50 disabled:cursor-not-allowed">
                    Next
                </button>
            </nav>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-black border-t border-green-500 mt-12 py-6">
        <div class="container mx-auto px-4 text-center text-gray-400">
            <p>&copy; 2024 Car Rental Service. All rights reserved.</p>
            <p class="text-sm mt-2">Secure payment management system</p>
        </div>
    </footer>

    <script src="/js/payment_management/my_payments.js"></script>
</body>
</html>