# Vehicle Image Feature - Implementation Guide

## Overview
Added vehicle image support to the DriveGo application. Vehicles can now have images displayed using image URLs.

## Changes Made

### 1. Database Schema Update
**Table:** `vehicles`
**New Column:** `image_url VARCHAR(500)`

```sql
ALTER TABLE vehicles ADD COLUMN image_url VARCHAR(500) AFTER model;
```

**Current Schema:**
```
+---------------------+--------------+------+-----+-------------------+-------------------+
| Field               | Type         | Null | Key | Default           | Extra             |
+---------------------+--------------+------+-----+-------------------+-------------------+
| vehicle_id          | int          | NO   | PRI | NULL              | auto_increment    |
| reg_no              | varchar(255) | NO   | UNI | NULL              |                   |
| model               | varchar(255) | NO   |     | NULL              |                   |
| image_url           | varchar(500) | YES  |     | NULL              |                   |
| mileage             | int          | YES  |     | NULL              |                   |
| rental_price        | double       | NO   |     | NULL              |                   |
| fuel_type           | varchar(255) | NO   |     | NULL              |                   |
| availability        | bit(1)       | NO   |     | NULL              |                   |
| condition           | varchar(100) | YES  |     | NULL              |                   |
| created_at          | datetime     | YES  |     | CURRENT_TIMESTAMP | DEFAULT_GENERATED |
| maintenance_history | varchar(255) | YES  |     | NULL              |                   |
+---------------------+--------------+------+-----+-------------------+-------------------+
```

### 2. Vehicle Entity Update
**File:** `src/main/java/com/drivego/vehicle/Vehicle.java`

**Added Field:**
```java
private String imageUrl;
```

**Added Getter/Setter:**
```java
public String getImageUrl() { return imageUrl; }
public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
```

### 3. Vehicle Form Update
**File:** `src/main/webapp/WEB-INF/jsp/vehicles/form.jsp`

**Added Input Field:**
```jsp
<div class="form-group">
    <label for="imageUrl" class="form-label">
        Vehicle Image URL
    </label>
    <input 
        type="url" 
        id="imageUrl" 
        name="imageUrl" 
        class="form-control"
        value="${vehicle.imageUrl}"
        placeholder="https://example.com/car-image.jpg"
    >
    <small class="form-text">Enter the URL of the vehicle image</small>
</div>
```

### 4. Vehicle List View Update
**File:** `src/main/webapp/WEB-INF/jsp/vehicles/list.jsp`

**Updated Image Display:**
```jsp
<div class="vehicle-card-image-enhanced">
    <c:choose>
        <c:when test="${not empty vehicle.imageUrl}">
            <img src="${vehicle.imageUrl}" alt="${vehicle.model}" class="vehicle-image-actual" />
        </c:when>
        <c:otherwise>
            <i class="fas fa-car"></i>
        </c:otherwise>
    </c:choose>
    <!-- Availability badge -->
</div>
```

**Added CSS:**
```css
.vehicle-image-actual {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: all 0.4s ease;
}

.vehicle-card-enhanced:hover .vehicle-image-actual {
    transform: scale(1.05);
}
```

## How to Use

### Adding Vehicle with Image
1. Go to `/vehicles/new`
2. Fill in vehicle details
3. Enter image URL in the "Vehicle Image URL" field
4. Click "Add Vehicle"

### Editing Vehicle Image
1. Go to `/vehicles` and click "Edit" on a vehicle
2. Update the "Vehicle Image URL" field
3. Click "Update Vehicle"

### Updating Existing Vehicles via Database
```sql
-- Update a specific vehicle
UPDATE vehicles 
SET image_url = 'https://example.com/car-image.jpg' 
WHERE reg_no = 'ABC-1234';

-- Bulk update example
UPDATE vehicles 
SET image_url = CONCAT('https://images.unsplash.com/photo-', vehicle_id, '?w=800') 
WHERE image_url IS NULL;
```

## Image URL Sources

### Recommended Free Image Sources:
1. **Unsplash** - https://unsplash.com/s/photos/car
   - Example: `https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=800`

2. **Pexels** - https://www.pexels.com/search/car/
   - Example: `https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?auto=compress&w=800`

3. **Pixabay** - https://pixabay.com/photos/search/car/
   - Example: `https://cdn.pixabay.com/photo/2012/05/29/00/43/car-49278_960_720.jpg`

### Best Practices:
- Use images with minimum 800px width for good quality
- Keep image file size under 500KB for faster loading
- Use HTTPS URLs for security
- Prefer horizontal/landscape orientation images
- Recommended aspect ratio: 16:9 or 4:3

## Display Behavior
- **With Image URL:** Displays the actual vehicle image with zoom effect on hover
- **Without Image URL:** Shows a car icon placeholder with gradient background
- **Image Effects:** 
  - Scale animation on hover (1.05x zoom)
  - Smooth transitions (0.4s ease)
  - Object-fit: cover (maintains aspect ratio)

## Visual Design
The vehicle cards feature:
- ✅ Modern gradient backgrounds (green to blue)
- ✅ Smooth hover animations
- ✅ Availability badges with glass-morphism effect
- ✅ Responsive grid/list view layouts
- ✅ Enhanced color scheme with complementary colors

## Testing
1. **Test with Image URL:**
   ```sql
   UPDATE vehicles 
   SET image_url = 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=800' 
   WHERE reg_no = 'ABC-1234';
   ```

2. **Test without Image URL:**
   ```sql
   UPDATE vehicles 
   SET image_url = NULL 
   WHERE reg_no = 'ABC-1234';
   ```

3. **Access:** http://localhost:8080/vehicles

## Technical Details
- **Field Type:** VARCHAR(500) - accommodates long URLs
- **Nullable:** YES - vehicles without images show placeholder
- **Validation:** URL format validation on form input
- **Security:** Using URL input type for basic validation
- **Performance:** Images loaded from external sources (no storage needed)

## Future Enhancements (Optional)
1. **File Upload:** Add file upload functionality instead of URLs
2. **Image Storage:** Store images in cloud storage (AWS S3, Azure Blob)
3. **Image Gallery:** Support multiple images per vehicle
4. **Image Validation:** Server-side URL validation
5. **Image Optimization:** Automatic image resizing and compression
6. **Default Images:** Category-specific default images (sedan, SUV, etc.)

## Notes
- Edit page (`vehicles/edit.jsp`) already had imageUrl field
- Application successfully compiled and running on port 8080
- Hibernate now includes `image_url` in SELECT queries
- No breaking changes to existing functionality
