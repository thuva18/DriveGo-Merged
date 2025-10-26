# Database Setup for Payment Storage - COMPLETE ✅

## ✅ Completed Setup

The `bank_payment_slips` table has been successfully created in your database!

```sql
-- Already created in your database
CREATE TABLE bank_payment_slips (
    slip_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    payment_id INT,
    car_booking_id BIGINT,
    user_email VARCHAR(255) NOT NULL,
    slip_filename VARCHAR(255) NOT NULL,
    file_path VARCHAR(500),
    file_size BIGINT,
    upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    verification_status VARCHAR(20) DEFAULT 'PENDING',
    verified_by VARCHAR(255),
    verified_date TIMESTAMP NULL,
    notes TEXT,
    INDEX idx_payment_id (payment_id),
    INDEX idx_car_booking_id (car_booking_id),
    INDEX idx_user_email (user_email),
    INDEX idx_verification_status (verification_status)
);
```

## Existing Tables Used

The following tables are already in your database and are being used:
- ✅ `creditcard_payments` - Stores credit card payment details
- ✅ `debitcard_payments` - Stores debit card payment details
- ✅ `bank_payment_slips` - Stores bank transfer receipt information (NEW)

## Payment Storage Flow

### Credit Card Payment with "Save Card"
1. User enters credit card details and checks "Save Card"
2. Payment is created in `payments` table
3. **After payment is saved**, card details are stored in `creditcard_payments` table:
   - `payment_id` - Links to the payment record (PRIMARY KEY)
   - `card_holder` - Cardholder name
   - `card_number` - Full card number (stored for this payment)
   - `expiry_date` - Card expiry date
   - `method_id` - Payment method ID (2 for credit card)

### Debit Card Payment with "Save Debit Card"
1. User enters debit card details and checks "Save Debit Card"
2. Payment is created in `payments` table
3. **After payment is saved**, card details are stored in `debitcard_payments` table:
   - `payment_id` - Links to the payment record (PRIMARY KEY)
   - `card_holder` - Cardholder name
   - `card_number` - Full card number (stored for this payment)
   - `bank` - Bank name (currently set to "N/A")
   - `method_id` - Payment method ID (3 for debit card)

### Bank Transfer Payment with Receipt Upload
1. User uploads payment receipt image
2. Payment is created in `payments` table
3. System stores file in `/uploads/payment-receipts/` directory
4. **After payment is saved**, record is stored in `bank_payment_slips` table:
   - `slip_id` - Auto-increment primary key
   - `payment_id` - Links to payments table
   - `car_booking_id` - Links to booking
   - `user_email` - Customer email
   - `slip_filename` - Unique filename
   - `file_path` - Full path to uploaded file
   - `file_size` - File size in bytes
   - `upload_date` - Timestamp of upload
   - `verification_status` - PENDING (default), VERIFIED, or REJECTED
   - `verified_by` - Admin who verified (NULL initially)
   - `verified_date` - When verified (NULL initially)
   - `notes` - Admin notes about verification

## Verification Workflow

Bank transfer receipts require admin verification:
- **PENDING**: Initial status when uploaded by customer
- **VERIFIED**: Admin has verified and approved the payment
- **REJECTED**: Admin has rejected the payment (with notes explaining why)

### Admin Queries

Check pending receipts:
```sql
SELECT * FROM bank_payment_slips WHERE verification_status = 'PENDING';
```

Verify a receipt:
```sql
UPDATE bank_payment_slips 
SET verification_status = 'VERIFIED', 
    verified_by = 'admin@email.com', 
    verified_date = NOW() 
WHERE slip_id = ?;
```

Reject a receipt:
```sql
UPDATE bank_payment_slips 
SET verification_status = 'REJECTED', 
    verified_by = 'admin@email.com', 
    verified_date = NOW(),
    notes = 'Reason for rejection' 
WHERE slip_id = ?;
```

## Security Notes

1. **Card Number Storage**: Full card numbers are stored only for completed payments (linked to payment_id)
2. **CVV**: Never stored anywhere (only used during transaction validation)
3. **Receipt Files**: Stored with unique filenames to prevent conflicts (format: `receipt_{bookingId}_{timestamp}.{ext}`)
4. **File Path**: Absolute path stored for admin retrieval and verification

## Testing Checklist

✅ Database table `bank_payment_slips` created successfully  
✅ Project compiled successfully without errors  
⏳ Test payment workflows (recommended):

1. **Credit Card Payment Test**:
   - Book a vehicle → Select Credit Card payment
   - Enter card details → Check "Save Card"
   - Complete payment → Verify entry in `creditcard_payments` table
   - Check `payment_id` matches the payment record

2. **Debit Card Payment Test**:
   - Book a vehicle → Select Debit Card payment  
   - Enter card details → Check "Save Debit Card"
   - Complete payment → Verify entry in `debitcard_payments` table
   - Check `payment_id` matches the payment record

3. **Bank Transfer Test**:
   - Book a vehicle → Select Bank Transfer
   - Upload receipt image
   - Complete payment → Verify:
     - File exists in `/uploads/payment-receipts/` directory
     - Entry in `bank_payment_slips` table with `verification_status = 'PENDING'`
     - `payment_id` and `car_booking_id` are correctly linked

4. **Payment Success Page**:
   - Verify success page displays correctly
   - Check auto-redirect to "My Bookings" after 5 seconds
   - Verify booking status updated to "CONFIRMED" (except cash payments)

## Important Notes

- **Card Storage Approach**: Cards are saved ONLY when a payment is made (not independently)
- **Primary Key**: `payment_id` is the primary key in card tables, so each payment can have one card record
- **Duplicate Payments**: If the same card is used multiple times, multiple records will exist (one per payment)
- **Bank Name**: Currently set to "N/A" for debit cards - update form if you want to capture bank name
- **File Upload Location**: `/uploads/payment-receipts/` - ensure this directory has proper write permissions

## Next Steps (Optional Enhancements)

1. **Add Bank Name Field**: Update debit card form to capture bank name
2. **Admin Verification UI**: Create admin interface to verify/reject bank transfer receipts
3. **Card Reuse**: If you want customers to reuse saved cards, create separate `saved_cards` table
4. **Payment Gateway**: Integrate with actual payment gateway (Stripe, PayPal, etc.) for live transactions
5. **Receipt Viewer**: Add admin interface to view uploaded payment receipts
