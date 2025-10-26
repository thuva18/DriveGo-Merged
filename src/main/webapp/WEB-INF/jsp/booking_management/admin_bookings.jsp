<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Manage Bookings</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .table-row:hover {
            background-color: #f8fafc;
        }
        .loading-skeleton {
            background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
            background-size: 200% 100%;
            animation: loading 1.5s infinite;
        }
        @keyframes loading {
            0% { background-position: 200% 0; }
            100% { background-position: -200% 0; }
        }
        .modal-backdrop {
            backdrop-filter: blur(4px);
        }
    </style>
</head>
<body class="bg-white min-h-screen">
    <!-- Header -->
    <header class="bg-white border-b border-gray-200 shadow-sm">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center py-6">
                <div class="flex items-center">
                    <button id="backButton" class="mr-4 p-2 rounded-md hover:bg-gray-100 transition duration-300">
                        <i class="fas fa-arrow-left text-black text-lg"></i>
                    </button>
                    <div>
                        <h1 class="text-3xl font-bold text-black">Admin - Manage Bookings</h1>
                        <p class="text-gray-600 mt-1">View, update, and delete car bookings</p>
                    </div>
                </div>
                <button id="refreshButton" class="bg-black text-white px-4 py-2 rounded-md hover:bg-gray-800 transition duration-300">
                    <i class="fas fa-sync-alt mr-2"></i>
                    Refresh
                </button>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <!-- Error Alert -->
        <div id="errorAlert" class="mb-6 bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-md hidden">
            <div class="flex items-center">
                <i class="fas fa-exclamation-circle mr-2"></i>
                <span id="errorMessage"></span>
            </div>
        </div>

        <!-- Success Alert -->
        <div id="successAlert" class="mb-6 bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded-md hidden">
            <div class="flex items-center">
                <i class="fas fa-check-circle mr-2"></i>
                <span id="successMessage"></span>
            </div>
        </div>

        <!-- Filters and Search -->
        <div class="bg-white border border-gray-200 rounded-lg shadow-sm p-6 mb-6">
            <h2 class="text-lg font-semibold text-black mb-4">
                <i class="fas fa-filter mr-2"></i>
                Filter & Search Bookings
            </h2>
            <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                <div>
                    <label for="searchEmail" class="block text-sm font-medium text-gray-700 mb-2">Search by Email</label>
                    <input type="email" id="searchEmail" placeholder="Enter email address" 
                           class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-black focus:border-transparent">
                </div>
                <div>
                    <label for="filterCar" class="block text-sm font-medium text-gray-700 mb-2">Filter by Car</label>
                    <select id="filterCar" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-black focus:border-transparent">
                        <option value="">All Cars</option>
                        <!-- Car options will be populated by JavaScript -->
                    </select>
                </div>
                <div>
                    <label for="filterContactName" class="block text-sm font-medium text-gray-700 mb-2">Contact Name</label>
                    <input type="text" id="filterContactName" placeholder="Enter contact name" 
                           class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-black focus:border-transparent">
                </div>
                <div class="flex items-end space-x-2">
                    <button id="searchButton" class="bg-black text-white px-4 py-2 rounded-md hover:bg-gray-800 transition duration-300 flex-1">
                        <i class="fas fa-search mr-2"></i>
                        Search
                    </button>
                    <button id="clearFiltersButton" class="bg-gray-500 text-white px-4 py-2 rounded-md hover:bg-gray-600 transition duration-300 flex-1">
                        <i class="fas fa-times mr-2"></i>
                        Clear
                    </button>
                </div>
            </div>
        </div>

        <!-- Booking Statistics -->
        <div id="bookingStats" class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-6 hidden">
            <div class="bg-white border border-gray-200 rounded-lg shadow-sm p-6">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-blue-100">
                        <i class="fas fa-calendar-check text-blue-600 text-xl"></i>
                    </div>
                    <div class="ml-4">
                        <p class="text-sm font-medium text-gray-600">Total Bookings</p>
                        <p class="text-2xl font-bold text-black" id="totalBookings">0</p>
                    </div>
                </div>
            </div>
            <div class="bg-white border border-gray-200 rounded-lg shadow-sm p-6">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-green-100">
                        <i class="fas fa-car text-green-600 text-xl"></i>
                    </div>
                    <div class="ml-4">
                        <p class="text-sm font-medium text-gray-600">Active Bookings</p>
                        <p class="text-2xl font-bold text-black" id="activeBookings">0</p>
                    </div>
                </div>
            </div>
            <div class="bg-white border border-gray-200 rounded-lg shadow-sm p-6">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-purple-100">
                        <i class="fas fa-users text-purple-600 text-xl"></i>
                    </div>
                    <div class="ml-4">
                        <p class="text-sm font-medium text-gray-600">Unique Customers</p>
                        <p class="text-2xl font-bold text-black" id="uniqueCustomers">0</p>
                    </div>
                </div>
            </div>
            <div class="bg-white border border-gray-200 rounded-lg shadow-sm p-6">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-orange-100">
                        <i class="fas fa-chart-line text-orange-600 text-xl"></i>
                    </div>
                    <div class="ml-4">
                        <p class="text-sm font-medium text-gray-600">This Month</p>
                        <p class="text-2xl font-bold text-black" id="monthlyBookings">0</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Loading Overlay -->
        <div id="loadingOverlay" class="bg-white border border-gray-200 rounded-lg shadow-sm p-6 mb-6">
            <div class="animate-pulse">
                <div class="flex items-center justify-between mb-4">
                    <div class="loading-skeleton h-6 w-48 rounded"></div>
                    <div class="loading-skeleton h-6 w-24 rounded"></div>
                </div>
                <div class="space-y-3">
                    <div class="loading-skeleton h-12 w-full rounded"></div>
                    <div class="loading-skeleton h-12 w-full rounded"></div>
                    <div class="loading-skeleton h-12 w-full rounded"></div>
                    <div class="loading-skeleton h-12 w-full rounded"></div>
                    <div class="loading-skeleton h-12 w-full rounded"></div>
                </div>
            </div>
        </div>

        <!-- Bookings Table -->
        <div id="tableContainer" class="bg-white border border-gray-200 rounded-lg shadow-sm overflow-hidden hidden">
            <div class="px-6 py-4 border-b border-gray-200">
                <div class="flex items-center justify-between">
                    <h3 class="text-lg font-semibold text-black">
                        <i class="fas fa-table mr-2"></i>
                        Bookings (<span id="bookingCount">0</span>)
                    </h3>
                </div>
            </div>
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Car</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Customer Email</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Contact Person</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Contact Number</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Booking Date</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Notes</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                        </tr>
                    </thead>
                    <tbody id="bookingsTableBody" class="bg-white divide-y divide-gray-200">
                        <!-- Table rows will be populated by JavaScript -->
                    </tbody>
                </table>
            </div>
        </div>

        <!-- No Bookings Message -->
        <div id="noBookingsMessage" class="text-center py-12 hidden">
            <div class="bg-white border border-gray-200 rounded-lg shadow-sm p-8">
                <i class="fas fa-calendar-times text-gray-400 text-6xl mb-4"></i>
                <h3 class="text-xl font-semibold text-gray-700 mb-2">No Bookings Found</h3>
                <p class="text-gray-500">No bookings match your search criteria or no bookings exist yet.</p>
            </div>
        </div>

        <!-- Pagination -->
        <div id="paginationContainer" class="flex items-center justify-between mt-6 hidden">
            <div class="flex items-center text-sm text-gray-700">
                <span>Showing <span id="showingStart">1</span> to <span id="showingEnd">10</span> of <span id="totalRecords">0</span> results</span>
            </div>
            <div class="flex items-center space-x-2">
                <button id="prevPageButton" class="px-3 py-2 rounded-md bg-gray-100 text-black hover:bg-gray-200 transition duration-300 disabled:opacity-50 disabled:cursor-not-allowed">
                    <i class="fas fa-chevron-left"></i>
                </button>
                <div id="pageNumbers" class="flex space-x-1">
                    <!-- Page numbers will be populated by JavaScript -->
                </div>
                <button id="nextPageButton" class="px-3 py-2 rounded-md bg-gray-100 text-black hover:bg-gray-200 transition duration-300 disabled:opacity-50 disabled:cursor-not-allowed">
                    <i class="fas fa-chevron-right"></i>
                </button>
            </div>
        </div>
    </main>

    <!-- Delete Confirmation Modal -->
    <div id="deleteModal" class="fixed inset-0 bg-black bg-opacity-50 modal-backdrop flex items-center justify-center z-50 hidden">
        <div class="bg-white rounded-lg shadow-xl max-w-md w-full mx-4">
            <div class="p-6">
                <div class="flex items-center mb-4">
                    <div class="p-3 rounded-full bg-red-100 mr-4">
                        <i class="fas fa-trash text-red-600 text-xl"></i>
                    </div>
                    <div>
                        <h3 class="text-lg font-semibold text-black">Delete Booking</h3>
                        <p class="text-gray-600">This action cannot be undone</p>
                    </div>
                </div>
                <p class="text-gray-700 mb-6">Are you sure you want to delete this booking? This will permanently remove the booking from the system.</p>
                <div class="flex space-x-3">
                    <button id="cancelDeleteButton" class="flex-1 px-4 py-2 border border-gray-300 rounded-md text-gray-700 hover:bg-gray-50 transition duration-300">
                        Cancel
                    </button>
                    <button id="confirmDeleteButton" class="flex-1 px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700 transition duration-300">
                        <i class="fas fa-trash mr-2"></i>
                        Delete
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Update Booking Modal -->
    <div id="updateModal" class="fixed inset-0 bg-black bg-opacity-50 modal-backdrop flex items-center justify-center z-50 hidden">
        <div class="bg-white rounded-lg shadow-xl max-w-2xl w-full mx-4 max-h-screen overflow-y-auto">
            <div class="p-6">
                <div class="flex items-center justify-between mb-6">
                    <div class="flex items-center">
                        <div class="p-3 rounded-full bg-blue-100 mr-4">
                            <i class="fas fa-edit text-blue-600 text-xl"></i>
                        </div>
                        <div>
                            <h3 class="text-lg font-semibold text-black">Update Booking</h3>
                            <p class="text-gray-600">Modify booking details</p>
                        </div>
                    </div>
                    <button id="closeUpdateModal" class="text-gray-400 hover:text-gray-600">
                        <i class="fas fa-times text-xl"></i>
                    </button>
                </div>
                
                <form id="updateBookingForm" class="space-y-4">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label for="updateCarId" class="block text-sm font-medium text-gray-700 mb-2">Car</label>
                            <select id="updateCarId" required class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-black focus:border-transparent">
                                <option value="">Select a car</option>
                                <!-- Car options will be populated by JavaScript -->
                            </select>
                        </div>
                        <div>
                            <label for="updateBookingDate" class="block text-sm font-medium text-gray-700 mb-2">Booking Date</label>
                            <input type="date" id="updateBookingDate" required 
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-black focus:border-transparent">
                        </div>
                    </div>
                    
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label for="updateBookedEmail" class="block text-sm font-medium text-gray-700 mb-2">Customer Email</label>
                            <input type="email" id="updateBookedEmail" required 
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-black focus:border-transparent">
                        </div>
                        <div>
                            <label for="updateContactPersonName" class="block text-sm font-medium text-gray-700 mb-2">Contact Person</label>
                            <input type="text" id="updateContactPersonName" required 
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-black focus:border-transparent">
                        </div>
                    </div>
                    
                    <div>
                        <label for="updateContactNumber" class="block text-sm font-medium text-gray-700 mb-2">Contact Number</label>
                        <input type="tel" id="updateContactNumber" required 
                               class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-black focus:border-transparent">
                    </div>
                    
                    <div>
                        <label for="updateAdditionalNotes" class="block text-sm font-medium text-gray-700 mb-2">Additional Notes</label>
                        <textarea id="updateAdditionalNotes" rows="3" 
                                  class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-black focus:border-transparent"
                                  placeholder="Any additional notes or requirements..."></textarea>
                    </div>
                </form>
                
                <div class="flex space-x-3 mt-6">
                    <button id="cancelUpdateButton" class="flex-1 px-4 py-2 border border-gray-300 rounded-md text-gray-700 hover:bg-gray-50 transition duration-300">
                        Cancel
                    </button>
                    <button id="confirmUpdateButton" class="flex-1 px-4 py-2 bg-black text-white rounded-md hover:bg-gray-800 transition duration-300">
                        <i class="fas fa-save mr-2"></i>
                        Update Booking
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="/js/cars.js"></script>
    <script src="/js/booking_management/admin_bookings.js"></script>
</body>
</html>