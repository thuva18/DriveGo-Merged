<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Payment Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .loading-skeleton {
            background: linear-gradient(90deg, #f3f4f6 25%, #e5e7eb 50%, #f3f4f6 75%);
            background-size: 200% 100%;
            animation: loading 1.5s infinite;
        }
        
        @keyframes loading {
            0% { background-position: 200% 0; }
            100% { background-position: -200% 0; }
        }
        
        .status-completed { @apply bg-green-50 text-green-700 border-green-200; }
        .status-failed { @apply bg-red-50 text-red-700 border-red-200; }
        .status-refunded { @apply bg-blue-50 text-blue-700 border-blue-200; }
        
        .table-row:hover { @apply bg-gray-50; }
        
        .dropdown-menu {
            display: none;
            position: absolute;
            top: 100%;
            right: 0;
            z-index: 1000;
            min-width: 160px;
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 0.375rem;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
        }
        
        .dropdown-menu.show {
            display: block;
        }
        
        .btn-primary {
            @apply bg-black text-white px-4 py-2 rounded-md hover:bg-gray-800 transition duration-300 font-medium;
        }
        
        .btn-secondary {
            @apply bg-gray-100 text-black px-4 py-2 rounded-md hover:bg-gray-200 transition duration-300 font-medium;
        }
        
        .btn-danger {
            @apply bg-red-600 text-white px-3 py-1.5 rounded-md hover:bg-red-700 transition duration-300 text-sm font-medium;
        }
    </style>
</head>
<body class="bg-white text-black min-h-screen">
    <!-- Header -->
    <header class="bg-white border-b border-gray-200 shadow-sm">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center py-6">
                <div class="flex items-center">
                    <button id="backButton" class="mr-4 p-2 rounded-md hover:bg-gray-100 transition duration-300">
                        <i class="fas fa-arrow-left text-black"></i>
                    </button>
                    <h1 class="text-2xl font-bold text-black">Payment Management</h1>
                </div>
                <div class="flex items-center space-x-4">
                    <span class="text-sm text-gray-600">Admin Dashboard</span>
                    <div class="w-8 h-8 bg-black rounded-full flex items-center justify-center">
                        <i class="fas fa-user text-white text-sm"></i>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <!-- Error Alert -->
        <div id="errorAlert" class="hidden mb-6 bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-md">
            <div class="flex items-center">
                <i class="fas fa-exclamation-circle mr-2"></i>
                <span id="errorMessage">An error occurred</span>
            </div>
        </div>

        <!-- Success Alert -->
        <div id="successAlert" class="hidden mb-6 bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded-md">
            <div class="flex items-center">
                <i class="fas fa-check-circle mr-2"></i>
                <span id="successMessage">Operation completed successfully</span>
            </div>
        </div>

        <!-- Filters and Search -->
        <div class="bg-white border border-gray-200 rounded-lg shadow-sm p-6 mb-8">
            <h2 class="text-lg font-semibold text-black mb-4">
                <i class="fas fa-filter mr-2"></i>
                Filters & Search
            </h2>
            
            <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-4">
                <div>
                    <label for="searchEmail" class="block text-sm font-medium text-black mb-2">Search by Email</label>
                    <input type="text" id="searchEmail" placeholder="Enter user email..." 
                           class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-black focus:border-transparent">
                </div>
                
                <div>
                    <label for="filterStatus" class="block text-sm font-medium text-black mb-2">Status</label>
                    <select id="filterStatus" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-black focus:border-transparent">
                        <option value="">All Statuses</option>
                        <option value="COMPLETED">Completed</option>
                        <option value="FAILED">Failed</option>
                        <option value="REFUNDED">Refunded</option>
                    </select>
                </div>
                
                <div>
                    <label for="filterPaymentType" class="block text-sm font-medium text-black mb-2">Payment Type</label>
                    <select id="filterPaymentType" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-black focus:border-transparent">
                        <option value="">All Types</option>
                        <option value="CARD">Card</option>
                        <option value="CASH">Cash</option>
                    </select>
                </div>
                
                <div class="flex items-end">
                    <button id="searchButton" class="btn-primary mr-2">
                        <i class="fas fa-search mr-2"></i>
                        Search
                    </button>
                    <button id="clearFiltersButton" class="btn-secondary">
                        <i class="fas fa-times mr-2"></i>
                        Clear
                    </button>
                </div>
            </div>
        </div>

        <!-- Payment Statistics -->
        <div id="paymentStats" class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8 hidden">
            <div class="bg-white border border-gray-200 rounded-lg shadow-sm p-6 text-center">
                <h3 class="text-lg font-semibold text-gray-600 mb-2">Total Payments</h3>
                <p id="totalPayments" class="text-3xl font-bold text-black">0</p>
            </div>
            <div class="bg-white border border-gray-200 rounded-lg shadow-sm p-6 text-center">
                <h3 class="text-lg font-semibold text-gray-600 mb-2">Completed</h3>
                <p id="completedPayments" class="text-3xl font-bold text-green-600">0</p>
            </div>
            <div class="bg-white border border-gray-200 rounded-lg shadow-sm p-6 text-center">
                <h3 class="text-lg font-semibold text-gray-600 mb-2">Failed</h3>
                <p id="failedPayments" class="text-3xl font-bold text-red-600">0</p>
            </div>
            <div class="bg-white border border-gray-200 rounded-lg shadow-sm p-6 text-center">
                <h3 class="text-lg font-semibold text-gray-600 mb-2">Total Amount</h3>
                <p id="totalAmount" class="text-3xl font-bold text-black">LKR 0</p>
            </div>
        </div>

        <!-- Payments Table -->
        <div class="bg-white border border-gray-200 rounded-lg shadow-sm overflow-hidden">
            <div class="px-6 py-4 border-b border-gray-200">
                <div class="flex justify-between items-center">
                    <h2 class="text-lg font-semibold text-black">
                        <i class="fas fa-credit-card mr-2"></i>
                        Payments (<span id="paymentCount">0</span>)
                    </h2>
                    <button id="refreshButton" class="btn-secondary">
                        <i class="fas fa-refresh mr-2"></i>
                        Refresh
                    </button>
                </div>
            </div>

            <!-- Loading State -->
            <div id="loadingOverlay" class="hidden">
                <div class="p-6">
                    <div class="space-y-4">
                        <div class="loading-skeleton h-12 w-full rounded"></div>
                        <div class="loading-skeleton h-12 w-full rounded"></div>
                        <div class="loading-skeleton h-12 w-full rounded"></div>
                        <div class="loading-skeleton h-12 w-full rounded"></div>
                        <div class="loading-skeleton h-12 w-full rounded"></div>
                    </div>
                </div>
            </div>

            <!-- Table -->
            <div id="tableContainer" class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Payment ID</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Booking ID</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">User Email</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Amount</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Payment Type</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                        </tr>
                    </thead>
                    <tbody id="paymentsTableBody" class="bg-white divide-y divide-gray-200">
                        <!-- Payment rows will be inserted here -->
                    </tbody>
                </table>
            </div>

            <!-- No Payments Message -->
            <div id="noPaymentsMessage" class="hidden p-12 text-center">
                <i class="fas fa-credit-card text-gray-300 text-6xl mb-4"></i>
                <h3 class="text-lg font-medium text-gray-600 mb-2">No payments found</h3>
                <p class="text-gray-500">No payments match your current filters.</p>
            </div>
        </div>

        <!-- Pagination -->
        <div id="paginationContainer" class="hidden mt-6 flex items-center justify-between">
            <div class="text-sm text-gray-600">
                Showing <span id="showingStart">1</span> to <span id="showingEnd">10</span> of <span id="totalRecords">0</span> results
            </div>
            <div class="flex items-center space-x-2">
                <button id="prevPageButton" class="px-3 py-2 rounded-md bg-gray-100 text-black hover:bg-gray-200 transition duration-300 disabled:opacity-50 disabled:cursor-not-allowed">
                    <i class="fas fa-chevron-left"></i>
                </button>
                <div id="pageNumbers" class="flex space-x-1">
                    <!-- Page numbers will be inserted here -->
                </div>
                <button id="nextPageButton" class="px-3 py-2 rounded-md bg-gray-100 text-black hover:bg-gray-200 transition duration-300 disabled:opacity-50 disabled:cursor-not-allowed">
                    <i class="fas fa-chevron-right"></i>
                </button>
            </div>
        </div>
    </main>

    <!-- Delete Confirmation Modal -->
    <div id="deleteModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
        <div class="bg-white rounded-lg p-6 max-w-md w-full mx-4">
            <div class="flex items-center mb-4">
                <i class="fas fa-exclamation-triangle text-red-500 text-2xl mr-3"></i>
                <h3 class="text-lg font-semibold text-black">Confirm Delete</h3>
            </div>
            <p class="text-gray-600 mb-6">Are you sure you want to delete this payment? This action cannot be undone.</p>
            <div class="flex justify-end space-x-3">
                <button id="cancelDeleteButton" class="btn-secondary">Cancel</button>
                <button id="confirmDeleteButton" class="btn-danger">
                    <i class="fas fa-trash mr-2"></i>
                    Delete
                </button>
            </div>
        </div>
    </div>

    <!-- Status Update Modal -->
    <div id="statusModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
        <div class="bg-white rounded-lg p-6 max-w-md w-full mx-4">
            <div class="flex items-center mb-4">
                <i class="fas fa-edit text-black text-2xl mr-3"></i>
                <h3 class="text-lg font-semibold text-black">Update Payment Status</h3>
            </div>
            <div class="mb-6">
                <label for="newStatus" class="block text-sm font-medium text-black mb-2">New Status</label>
                <select id="newStatus" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-black focus:border-transparent">
                    <option value="COMPLETED">Completed</option>
                    <option value="FAILED">Failed</option>
                    <option value="REFUNDED">Refunded</option>
                </select>
            </div>
            <div class="flex justify-end space-x-3">
                <button id="cancelStatusButton" class="btn-secondary">Cancel</button>
                <button id="confirmStatusButton" class="btn-primary">
                    <i class="fas fa-save mr-2"></i>
                    Update Status
                </button>
            </div>
        </div>
    </div>

    <script src="/js/payment_management/admin_payments.js"></script>
</body>
</html>