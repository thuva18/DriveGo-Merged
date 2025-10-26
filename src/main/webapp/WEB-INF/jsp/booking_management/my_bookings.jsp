<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings - DriveGo</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background-color: #f8fafc;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            margin: 0;
            padding: 0;
        }
        .card-shadow {
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        }
        .btn-primary {
            background-color: #00ff88;
            color: #000000;
            transition: all 0.2s ease-in-out;
            border: none;
            cursor: pointer;
            font-weight: 600;
        }
        .btn-primary:hover {
            background-color: #00cc6a;
            transform: translateY(-1px);
        }
        .btn-secondary {
            background-color: #6b7280;
            color: white;
            transition: all 0.2s ease-in-out;
            border: none;
            cursor: pointer;
            font-weight: 500;
        }
        .btn-secondary:hover {
            background-color: #4b5563;
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
            background-color: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(4px);
        }
        .fade-in {
            animation: fadeIn 0.3s ease-in-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .page-header-section {
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
            padding: 2rem 0;
            margin-bottom: 2rem;
        }
        
        .page-header-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
        }
        
        .page-title {
            font-size: 2rem;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 0.5rem;
        }
        
        .page-subtitle {
            color: #64748b;
            font-size: 1.1rem;
        }
    </style>
</head>
<body>
    <!-- Include Customer Header -->
    <jsp:include page="../customer_header.jsp" />
    
    <!-- Page Header Section -->
    <div class="page-header-section">
        <div class="page-header-content">
            <h1 class="page-title">
                <i class="fas fa-calendar-check mr-3"></i>
                My Bookings
            </h1>
            <p class="page-subtitle">View and manage your car rental bookings</p>
        </div>
    </div>

    <!-- Main Content -->
    <main class="container mx-auto px-4 py-8">
        <!-- Statistics Cards -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            <div class="bg-white rounded-lg card-shadow p-6">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-blue-100 text-blue-600">
                        <i class="fas fa-calendar-alt text-xl"></i>
                    </div>
                    <div class="ml-4">
                        <p class="text-sm font-medium text-gray-600">Total Bookings</p>
                        <p id="totalBookings" class="text-2xl font-bold text-gray-900">-</p>
                    </div>
                </div>
            </div>
            <div class="bg-white rounded-lg card-shadow p-6">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-green-100 text-green-600">
                        <i class="fas fa-check-circle text-xl"></i>
                    </div>
                    <div class="ml-4">
                        <p class="text-sm font-medium text-gray-600">Active Bookings</p>
                        <p id="activeBookings" class="text-2xl font-bold text-gray-900">-</p>
                    </div>
                </div>
            </div>
            <div class="bg-white rounded-lg card-shadow p-6">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-purple-100 text-purple-600">
                        <i class="fas fa-car text-xl"></i>
                    </div>
                    <div class="ml-4">
                        <p class="text-sm font-medium text-gray-600">Cars Booked</p>
                        <p id="uniqueCars" class="text-2xl font-bold text-gray-900">-</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Filter and Search Section -->
        <div class="bg-white rounded-lg card-shadow p-6 mb-8">
            <h2 class="text-xl font-semibold text-gray-900 mb-4">
                <i class="fas fa-filter mr-2"></i>
                Filter & Search Bookings
            </h2>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div>
                    <label for="searchEmail" class="block text-sm font-medium text-gray-700 mb-2">Search by Email</label>
                    <input type="email" id="searchEmail" placeholder="Enter email address" 
                           class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-gray-500 focus:border-transparent">
                </div>
                <div>
                    <label for="filterCar" class="block text-sm font-medium text-gray-700 mb-2">Filter by Car</label>
                    <select id="filterCar" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-gray-500 focus:border-transparent">
                        <option value="">All Cars</option>
                        <!-- Car options will be populated by JavaScript -->
                    </select>
                </div>
                <div>
                    <label for="filterContactName" class="block text-sm font-medium text-gray-700 mb-2">Contact Name</label>
                    <input type="text" id="filterContactName" placeholder="Enter contact name" 
                           class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-gray-500 focus:border-transparent">
                </div>
            </div>
            <div class="flex justify-end mt-4 space-x-3">
                <button id="clearFiltersBtn" class="btn-secondary px-4 py-2 rounded-lg font-medium">
                    <i class="fas fa-times mr-2"></i>
                    Clear Filters
                </button>
                <button id="applyFiltersBtn" class="btn-primary px-4 py-2 rounded-lg font-medium">
                    <i class="fas fa-search mr-2"></i>
                    Apply Filters
                </button>
            </div>
        </div>

        <!-- Bookings Table -->
        <div class="bg-white rounded-lg card-shadow overflow-hidden">
            <div class="px-6 py-4 border-b border-gray-200">
                <h2 class="text-xl font-semibold text-gray-900">
                    <i class="fas fa-list mr-2"></i>
                    Your Bookings
                </h2>
            </div>
            
            <!-- Loading State -->
            <div id="loadingState" class="p-6">
                <div class="space-y-4">
                    <div class="loading-skeleton h-4 rounded w-3/4"></div>
                    <div class="loading-skeleton h-4 rounded w-1/2"></div>
                    <div class="loading-skeleton h-4 rounded w-5/6"></div>
                </div>
            </div>

            <!-- Error State -->
            <div id="errorState" class="p-6 text-center hidden">
                <div class="text-red-500 mb-4">
                    <i class="fas fa-exclamation-triangle text-4xl"></i>
                </div>
                <h3 class="text-lg font-semibold text-gray-900 mb-2">Error Loading Bookings</h3>
                <p class="text-gray-600 mb-4" id="errorMessage">Something went wrong while loading your bookings.</p>
                <button id="retryBtn" class="btn-primary px-4 py-2 rounded-lg font-medium">
                    <i class="fas fa-redo mr-2"></i>
                    Try Again
                </button>
            </div>

            <!-- Empty State -->
            <div id="emptyState" class="p-12 text-center hidden">
                <div class="text-gray-400 mb-4">
                    <i class="fas fa-calendar-times text-6xl"></i>
                </div>
                <h3 class="text-lg font-semibold text-gray-900 mb-2">No Bookings Found</h3>
                <p class="text-gray-600 mb-6">You haven't made any car bookings yet.</p>
                <button onclick="window.location.href='/'" class="btn-primary px-6 py-3 rounded-lg font-medium">
                    <i class="fas fa-plus mr-2"></i>
                    Book Your First Car
                </button>
            </div>

            <!-- Table -->
            <div id="bookingsTable" class="hidden">
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                            <tr>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Booking Details</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Car</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Contact Info</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                            </tr>
                        </thead>
                        <tbody id="bookingsTableBody" class="bg-white divide-y divide-gray-200">
                            <!-- Table rows will be populated by JavaScript -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Pagination -->
        <div id="paginationContainer" class="mt-6 flex justify-between items-center hidden">
            <div class="text-sm text-gray-700">
                Showing <span id="showingFrom">1</span> to <span id="showingTo">10</span> of <span id="totalRecords">0</span> results
            </div>
            <div class="flex space-x-2">
                <button id="prevPageBtn" class="btn-secondary px-3 py-2 rounded-lg font-medium disabled:opacity-50 disabled:cursor-not-allowed">
                    <i class="fas fa-chevron-left mr-1"></i>
                    Previous
                </button>
                <div id="pageNumbers" class="flex space-x-1">
                    <!-- Page numbers will be populated by JavaScript -->
                </div>
                <button id="nextPageBtn" class="btn-secondary px-3 py-2 rounded-lg font-medium disabled:opacity-50 disabled:cursor-not-allowed">
                    Next
                    <i class="fas fa-chevron-right ml-1"></i>
                </button>
            </div>
        </div>
    </main>

    <!-- Update Booking Modal -->
    <div id="updateModal" class="fixed inset-0 z-50 hidden modal-backdrop">
        <div class="flex items-center justify-center min-h-screen px-4">
            <div class="bg-white rounded-lg card-shadow max-w-md w-full fade-in">
                <div class="px-6 py-4 border-b border-gray-200">
                    <h3 class="text-lg font-semibold text-gray-900">
                        <i class="fas fa-edit mr-2"></i>
                        Update Booking
                    </h3>
                </div>
                <form id="updateBookingForm" class="p-6 space-y-4">
                    <input type="hidden" id="updateBookingId">
                    
                    <div>
                        <label for="updateCarId" class="block text-sm font-medium text-gray-700 mb-2">Car</label>
                        <select id="updateCarId" required class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-gray-500 focus:border-transparent">
                            <option value="">Select a car</option>
                            <!-- Car options will be populated by JavaScript -->
                        </select>
                    </div>
                    
                    <div>
                        <label for="updateBookingDate" class="block text-sm font-medium text-gray-700 mb-2">Booking Date</label>
                        <input type="date" id="updateBookingDate" required 
                               class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-gray-500 focus:border-transparent">
                    </div>
                    
                    <div>
                        <label for="updateBookedEmail" class="block text-sm font-medium text-gray-700 mb-2">Email</label>
                        <input type="email" id="updateBookedEmail" required 
                               class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-gray-500 focus:border-transparent">
                    </div>
                    
                    <div>
                        <label for="updateContactNumber" class="block text-sm font-medium text-gray-700 mb-2">Contact Number</label>
                        <input type="tel" id="updateContactNumber" required 
                               class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-gray-500 focus:border-transparent">
                    </div>
                    
                    <div>
                        <label for="updateContactPersonName" class="block text-sm font-medium text-gray-700 mb-2">Contact Person Name</label>
                        <input type="text" id="updateContactPersonName" required 
                               class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-gray-500 focus:border-transparent">
                    </div>
                    
                    <div>
                        <label for="updateAdditionalNotes" class="block text-sm font-medium text-gray-700 mb-2">Additional Notes</label>
                        <textarea id="updateAdditionalNotes" rows="3" 
                                  class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-gray-500 focus:border-transparent"
                                  placeholder="Any additional notes or requirements..."></textarea>
                    </div>
                </form>
                <div class="px-6 py-4 border-t border-gray-200 flex justify-end space-x-3">
                    <button id="cancelUpdateBtn" class="btn-secondary px-4 py-2 rounded-lg font-medium">
                        <i class="fas fa-times mr-2"></i>
                        Cancel
                    </button>
                    <button id="confirmUpdateBtn" class="btn-primary px-4 py-2 rounded-lg font-medium">
                        <i class="fas fa-save mr-2"></i>
                        Update Booking
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Success/Error Messages -->
    <div id="messageContainer" class="fixed top-4 right-4 z-50 space-y-2">
        <!-- Messages will be populated by JavaScript -->
    </div>

    <!-- Scripts -->
    <script src="/js/cars.js"></script>
    <script src="/js/booking_management/my_bookings.js"></script>
</body>
</html>