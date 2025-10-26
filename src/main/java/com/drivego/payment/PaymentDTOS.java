package com.drivego.payment;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class PaymentDTOS {

    // Request DTO for creating a new payment
    public static class CreateRequest {
        private Long bookingId;
        private BigDecimal amount;
        private String paymentMethod;

        public CreateRequest() {}

        // Getters and Setters
        public Long getBookingId() { return bookingId; }
        public void setBookingId(Long bookingId) { this.bookingId = bookingId; }

        public BigDecimal getAmount() { return amount; }
        public void setAmount(BigDecimal amount) { this.amount = amount; }

        public String getPaymentMethod() { return paymentMethod; }
        public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    }

    // Response DTO for returning payment data
    public static class Response {
        private Long id;
        private Long bookingId;
        private BigDecimal amount;
        private String paymentMethod;
        private String paymentStatus;
        private String transactionId;
        private Date createdAt;
        private Date updatedAt;

        public Response() {}

        // Getters and Setters
        public Long getId() { return id; }
        public void setId(Long id) { this.id = id; }

        public Long getBookingId() { return bookingId; }
        public void setBookingId(Long bookingId) { this.bookingId = bookingId; }

        public BigDecimal getAmount() { return amount; }
        public void setAmount(BigDecimal amount) { this.amount = amount; }

        public String getPaymentMethod() { return paymentMethod; }
        public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

        public String getPaymentStatus() { return paymentStatus; }
        public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }

        public String getTransactionId() { return transactionId; }
        public void setTransactionId(String transactionId) { this.transactionId = transactionId; }

        public Date getCreatedAt() { return createdAt; }
        public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

        public Date getUpdatedAt() { return updatedAt; }
        public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }
    }

    // List response DTO for paginated results
    public static class ListResponse {
        private List<Response> payments;
        private int totalElements;
        private int totalPages;
        private int currentPage;
        private int size;

        public ListResponse() {}

        public ListResponse(List<Response> payments, int totalElements, int currentPage, int size) {
            this.payments = payments;
            this.totalElements = totalElements;
            this.currentPage = currentPage;
            this.size = size;
            this.totalPages = (int) Math.ceil((double) totalElements / size);
        }

        // Getters and Setters
        public List<Response> getPayments() { return payments; }
        public void setPayments(List<Response> payments) { this.payments = payments; }

        public int getTotalElements() { return totalElements; }
        public void setTotalElements(int totalElements) { this.totalElements = totalElements; }

        public int getTotalPages() { return totalPages; }
        public void setTotalPages(int totalPages) { this.totalPages = totalPages; }

        public int getCurrentPage() { return currentPage; }
        public void setCurrentPage(int currentPage) { this.currentPage = currentPage; }

        public int getSize() { return size; }
        public void setSize(int size) { this.size = size; }
    }

    // Statistics response DTO for payment analytics
    public static class StatsResponse {
        private long totalPayments;
        private BigDecimal totalRevenue;
        private long pendingPayments;
        private long completedPayments;
        private long failedPayments;
        private long refundedPayments;

        public StatsResponse() {}

        // Getters and Setters
        public long getTotalPayments() { return totalPayments; }
        public void setTotalPayments(long totalPayments) { this.totalPayments = totalPayments; }

        public BigDecimal getTotalRevenue() { return totalRevenue; }
        public void setTotalRevenue(BigDecimal totalRevenue) { this.totalRevenue = totalRevenue; }

        public long getPendingPayments() { return pendingPayments; }
        public void setPendingPayments(long pendingPayments) { this.pendingPayments = pendingPayments; }

        public long getCompletedPayments() { return completedPayments; }
        public void setCompletedPayments(long completedPayments) { this.completedPayments = completedPayments; }

        public long getFailedPayments() { return failedPayments; }
        public void setFailedPayments(long failedPayments) { this.failedPayments = failedPayments; }

        public long getRefundedPayments() { return refundedPayments; }
        public void setRefundedPayments(long refundedPayments) { this.refundedPayments = refundedPayments; }
    }

    // Request DTO for updating payment status
    public static class UpdateStatusRequest {
        private String status;
        private String reason;

        public UpdateStatusRequest() {}

        // Getters and Setters
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }

        public String getReason() { return reason; }
        public void setReason(String reason) { this.reason = reason; }
    }

    // Search request DTO for filtering payments
    public static class SearchRequest {
        private Long bookingId;
        private String status;
        private String method;
        private String startDate;
        private String endDate;
        private int page = 0;
        private int size = 10;

        public SearchRequest() {}

        // Getters and Setters
        public Long getBookingId() { return bookingId; }
        public void setBookingId(Long bookingId) { this.bookingId = bookingId; }

        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }

        public String getMethod() { return method; }
        public void setMethod(String method) { this.method = method; }

        public String getStartDate() { return startDate; }
        public void setStartDate(String startDate) { this.startDate = startDate; }

        public String getEndDate() { return endDate; }
        public void setEndDate(String endDate) { this.endDate = endDate; }

        public int getPage() { return page; }
        public void setPage(int page) { this.page = page; }

        public int getSize() { return size; }
        public void setSize(int size) { this.size = size; }
    }
}