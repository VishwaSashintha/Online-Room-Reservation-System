const ROOM_PRICES = {
    'Standard': 8000,
    'Deluxe': 12000,
    'Suite': 20000
};
function calculateBill() {
    const roomType = document.getElementById('roomType')?.value;
    const checkIn = document.getElementById('checkIn')?.value;
    const checkOut = document.getElementById('checkOut')?.value;
    const totalBillField = document.getElementById('totalBill');
    if (!roomType || !checkIn || !checkOut || !totalBillField) {
        return;
    }
    const checkInDate = new Date(checkIn);
    const checkOutDate = new Date(checkOut);
    if (checkOutDate <= checkInDate) {
        totalBillField.value = '0.00';
        return;
    }
    const timeDiff = checkOutDate.getTime() - checkInDate.getTime();
    const nights = Math.ceil(timeDiff / (1000 * 3600 * 24));
    const ratePerNight = ROOM_PRICES[roomType] || 0;
    const totalBill = nights * ratePerNight;
    totalBillField.value = totalBill.toFixed(2);
    updateBillingSummary(roomType, ratePerNight, nights, totalBill);
}
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
function validateDates() {
    const checkIn = document.getElementById('checkIn')?.value;
    const checkOut = document.getElementById('checkOut')?.value;
    const dateError = document.getElementById('dateError');
    if (!checkIn || !checkOut) return true;
    const checkInDate = new Date(checkIn);
    const checkOutDate = new Date(checkOut);
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    if (checkInDate < today) {
        if (dateError) {
            dateError.textContent = 'Check-in date cannot be in the past';
            dateError.style.color = 'var(--error-red)';
            dateError.style.display = 'block';
        }
        return false;
    }
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
function validateReservationForm(event) {
    let isValid = true;
    const guestName = document.getElementById('guestName')?.value.trim();
    if (!guestName) {
        showError('Guest name is required!');
        isValid = false;
    }
    const contactInput = document.getElementById('contact');
    if (contactInput && !validateContact(contactInput)) {
        isValid = false;
    }
    if (!validateDates()) {
        isValid = false;
    }
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
function showError(message) {
    const errorDiv = document.getElementById('formError');
    if (errorDiv) {
        errorDiv.textContent = message;
        errorDiv.className = 'alert alert-error';
        errorDiv.style.display = 'block';
        errorDiv.scrollIntoView({ behavior: 'smooth', block: 'center' });
    } else {
        alert(message);
    }
}
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
function toggleAccordion(element) {
    const content = element.nextElementSibling;
    const isActive = element.classList.contains('active');
    document.querySelectorAll('.accordion-header').forEach(header => {
        header.classList.remove('active');
        header.nextElementSibling.classList.remove('active');
    });
    if (!isActive) {
        element.classList.add('active');
        content.classList.add('active');
    }
}
function confirmDelete() {
    return confirm('Are you sure you want to delete this reservation? This action cannot be undone.');
}
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
document.addEventListener('DOMContentLoaded', function () {
    autoHideAlerts();
    setMinimumDates();
    const roomTypeSelect = document.getElementById('roomType');
    const checkInInput = document.getElementById('checkIn');
    const checkOutInput = document.getElementById('checkOut');
    if (roomTypeSelect) {
        roomTypeSelect.addEventListener('change', calculateBill);
    }
    if (checkInInput) {
        checkInInput.addEventListener('change', function () {
            validateDates();
            calculateBill();
        });
    }
    if (checkOutInput) {
        checkOutInput.addEventListener('change', function () {
            validateDates();
            calculateBill();
        });
    }
    const contactInput = document.getElementById('contact');
    if (contactInput) {
        contactInput.addEventListener('blur', function () {
            validateContact(this);
        });
        contactInput.addEventListener('input', function () {
            this.value = this.value.replace(/\D/g, '');
        });
    }
});
