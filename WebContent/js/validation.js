/**
 * Ocean View Resort - Client-Side Validation
 * JavaScript validation for forms and user interactions
 */

// Room prices configuration
const ROOM_PRICES = {
    'Standard': 8000,
    'Deluxe': 12000,
    'Suite': 20000
};

/**
 * Calculate total bill based on room type and dates
 */
function calculateBill() {
    const roomType = document.getElementById('roomType')?.value;
    const checkIn = document.getElementById('checkIn')?.value;
    const checkOut = document.getElementById('checkOut')?.value;
    const totalBillField = document.getElementById('totalBill');
    
    if (!roomType || !checkIn || !checkOut || !totalBillField) {
        return;
    }
    
    // Validate dates
    const checkInDate = new Date(checkIn);
    const checkOutDate = new Date(checkOut);
    
    if (checkOutDate <= checkInDate) {
        totalBillField.value = '0.00';
        return;
    }
    
    // Calculate number of nights
    const timeDiff = checkOutDate.getTime() - checkInDate.getTime();
    const nights = Math.ceil(timeDiff / (1000 * 3600 * 24));
    
    // Calculate total bill
    const ratePerNight = ROOM_PRICES[roomType] || 0;
    const totalBill = nights * ratePerNight;
    
    totalBillField.value = totalBill.toFixed(2);
    
    // Update billing summary if exists
    updateBillingSummary(roomType, ratePerNight, nights, totalBill);
}

/**
 * Update billing summary display
 */
function updateBillingSummary(roomType, rate, nights, total) {
    const summaryDiv = document.getElementById('billingSummary');
    
    if (!summaryDiv) return;
    
    summaryDiv.innerHTML = `
        <h4>Billing Summary</h4>
        <div class="billing-row">
            <span>Room Type:</span>
            <strong>${roomType}</strong>
        </div>
        <div class="billing-row">
            <span>Rate per Night:</span>
            <strong>LKR ${rate.toLocaleString()}</strong>
        </div>
        <div class="billing-row">
            <span>Number of Nights:</span>
            <strong>${nights}</strong>
        </div>
        <div class="billing-row total">
            <span>Total Amount:</span>
            <strong>LKR ${total.toLocaleString()}</strong>
        </div>
    `;
    
    summaryDiv.style.display = 'block';
}

/**
 * Validate contact number (10 digits)
 */
function validateContact(input) {
    const contact = input.value.trim();
    const contactError = document.getElementById('contactError');
    
    if (contact && !/^\d{10}$/.test(contact)) {
        if (contactError) {
            contactError.textContent = 'Contact must be exactly 10 digits';
            contactError.style.color = 'var(--error-red)';
            contactError.style.display = 'block';
        }
        input.style.borderColor = 'var(--error-red)';
        return false;
    } else {
        if (contactError) {
            contactError.style.display = 'none';
        }
        input.style.borderColor = 'var(--border-color)';
        return true;
    }
}

/**
 * Validate check-in and check-out dates
 */
function validateDates() {
    const checkIn = document.getElementById('checkIn')?.value;
    const checkOut = document.getElementById('checkOut')?.value;
    const dateError = document.getElementById('dateError');
    
    if (!checkIn || !checkOut) return true;
    
    const checkInDate = new Date(checkIn);
    const checkOutDate = new Date(checkOut);
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    
    // Check if check-in is in the past
    if (checkInDate < today) {
        if (dateError) {
            dateError.textContent = 'Check-in date cannot be in the past';
            dateError.style.color = 'var(--error-red)';
            dateError.style.display = 'block';
        }
        return false;
    }
    
    // Check if check-out is after check-in
    if (checkOutDate <= checkInDate) {
        if (dateError) {
            dateError.textContent = 'Check-out date must be after check-in date';
            dateError.style.color = 'var(--error-red)';
            dateError.style.display = 'block';
        }
        return false;
    }
    
    if (dateError) {
        dateError.style.display = 'none';
    }
    
    return true;
}

/**
 * Validate reservation form before submission
 */
function validateReservationForm(event) {
    let isValid = true;
    
    // Validate guest name
    const guestName = document.getElementById('guestName')?.value.trim();
    if (!guestName) {
        showError('Guest name is required!');
        isValid = false;
    }
    
    // Validate contact
    const contactInput = document.getElementById('contact');
    if (contactInput && !validateContact(contactInput)) {
        isValid = false;
    }
    
    // Validate dates
    if (!validateDates()) {
        isValid = false;
    }
    
    // Validate reservation ID (for add form)
    const reservationId = document.getElementById('reservationId')?.value;
    if (reservationId && (isNaN(reservationId) || reservationId <= 0)) {
        showError('Reservation ID must be a positive number!');
        isValid = false;
    }
    
    if (!isValid && event) {
        event.preventDefault();
    }
    
    return isValid;
}

/**
 * Show error message
 */
function showError(message) {
    const errorDiv = document.getElementById('formError');
    if (errorDiv) {
        errorDiv.textContent = message;
        errorDiv.className = 'alert alert-error';
        errorDiv.style.display = 'block';
        
        // Scroll to error
        errorDiv.scrollIntoView({ behavior: 'smooth', block: 'center' });
    } else {
        alert(message);
    }
}

/**
 * Toggle password visibility
 */
function togglePassword() {
    const passwordInput = document.getElementById('password');
    const toggleBtn = document.getElementById('passwordToggle');
    
    if (passwordInput && toggleBtn) {
        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            toggleBtn.textContent = 'Hide';
        } else {
            passwordInput.type = 'password';
            toggleBtn.textContent = 'Show';
        }
    }
}

/**
 * Validate login form
 */
function validateLoginForm(event) {
    const username = document.getElementById('username')?.value.trim();
    const password = document.getElementById('password')?.value;
    
    if (!username || !password) {
        showError('Username and password are required!');
        if (event) event.preventDefault();
        return false;
    }
    
    return true;
}

/**
 * Accordion functionality for help page
 */
function toggleAccordion(element) {
    const content = element.nextElementSibling;
    const isActive = element.classList.contains('active');
    
    // Close all accordions
    document.querySelectorAll('.accordion-header').forEach(header => {
        header.classList.remove('active');
        header.nextElementSibling.classList.remove('active');
    });
    
    // Open clicked accordion if it wasn't active
    if (!isActive) {
        element.classList.add('active');
        content.classList.add('active');
    }
}

/**
 * Confirm deletion
 */
function confirmDelete() {
    return confirm('Are you sure you want to delete this reservation? This action cannot be undone.');
}

/**
 * Auto-hide alerts after 5 seconds
 */
function autoHideAlerts() {
    const alerts = document.querySelectorAll('.alert-success');
    alerts.forEach(alert => {
        setTimeout(() => {
            alert.style.transition = 'opacity 0.5s ease';
            alert.style.opacity = '0';
            setTimeout(() => {
                alert.style.display = 'none';
            }, 500);
        }, 5000);
    });
}

/**
 * Set minimum date for date inputs (today)
 */
function setMinimumDates() {
    const today = new Date().toISOString().split('T')[0];
    const checkInInput = document.getElementById('checkIn');
    const checkOutInput = document.getElementById('checkOut');
    
    if (checkInInput) {
        checkInInput.setAttribute('min', today);
    }
    
    if (checkOutInput) {
        checkOutInput.setAttribute('min', today);
    }
}

/**
 * Initialize page
 */
document.addEventListener('DOMContentLoaded', function() {
    // Auto-hide success alerts
    autoHideAlerts();
    
    // Set minimum dates for date inputs
    setMinimumDates();
    
    // Add event listeners for bill calculation
    const roomTypeSelect = document.getElementById('roomType');
    const checkInInput = document.getElementById('checkIn');
    const checkOutInput = document.getElementById('checkOut');
    
    if (roomTypeSelect) {
        roomTypeSelect.addEventListener('change', calculateBill);
    }
    
    if (checkInInput) {
        checkInInput.addEventListener('change', function() {
            validateDates();
            calculateBill();
        });
    }
    
    if (checkOutInput) {
        checkOutInput.addEventListener('change', function() {
            validateDates();
            calculateBill();
        });
    }
    
    // Add contact validation
    const contactInput = document.getElementById('contact');
    if (contactInput) {
        contactInput.addEventListener('blur', function() {
            validateContact(this);
        });
        contactInput.addEventListener('input', function() {
            // Only allow digits
            this.value = this.value.replace(/\D/g, '');
        });
    }
});
