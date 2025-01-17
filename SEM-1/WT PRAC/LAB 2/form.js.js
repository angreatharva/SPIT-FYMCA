document.getElementById("firstName").addEventListener("blur", validateFirstName);
document.getElementById("lastName").addEventListener("blur", validateLastName);
document.getElementById("email").addEventListener("blur", validateEmail);
document.getElementById("mobileNo").addEventListener("blur", validateMobile);
document.getElementById("password").addEventListener("blur", validatePassword);
document.getElementById("confirmPassword").addEventListener("blur", validateConfirmPassword);
document.getElementById("registrationForm").addEventListener("submit", function(event) {
    validateForm(event);
});

function validateFirstName() {
    let firstName = document.getElementById("firstName").value;
    let firstNameError = document.getElementById("firstNameError");
    firstNameError.textContent = "";
    if (firstName === "") {
        firstNameError.textContent = "Please enter your First Name";
    } else if (/\d/.test(firstName) || /[^a-zA-Z]/.test(firstName)) {
        firstNameError.textContent = "Please enter your First Name properly";
    }
}

function validateLastName() {
    let lastName = document.getElementById("lastName").value;
    let lastNameError = document.getElementById("lastNameError");
    lastNameError.textContent = "";
    if (lastName === "") {
        lastNameError.textContent = "Please enter your Last Name";
    } else if (/\d/.test(lastName) || /[^a-zA-Z]/.test(lastName)) {
        lastNameError.textContent = "Please enter your Last Name properly";
    }
}

function validateEmail() {
    let email = document.getElementById("email").value;
    let emailError = document.getElementById("emailError");
    emailError.textContent = "";
    let emailPattern = /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
    if (!emailPattern.test(email)) {
        emailError.textContent = "Please enter a valid Email";
    }
}

function validateMobile() {
    let mobile = document.getElementById("mobileNo").value;
    let mobileError = document.getElementById("mobileError");
    mobileError.textContent = "";
    if (!/^\d{10}$/.test(mobile)) {
        mobileError.textContent = "Please enter a valid 10-digit Mobile Number";
    }
}

function validatePassword() {
    let password = document.getElementById("password").value;
    let passwordError = document.getElementById("passwordError");
    passwordError.textContent = "";
    let passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$/;
    if (!passwordPattern.test(password)) {
        passwordError.textContent = "Password must contain 6+ chars, uppercase, lowercase, number, symbol";
    }
}

function validateConfirmPassword() {
    let confirmPassword = document.getElementById("confirmPassword").value;
    let password = document.getElementById("password").value;
    let confirmPasswordError = document.getElementById("confirmPasswordError");
    confirmPasswordError.textContent = "";
    if (confirmPassword !== password) {
        confirmPasswordError.textContent = "Passwords do not match";
    }
}

function validateForm(event) {
    validateFirstName();
    validateLastName();
    validateEmail();
    validateMobile();
    validatePassword();
    validateConfirmPassword();

    let errors = document.getElementsByClassName("error-message");
    let hasError = false;

    for (let i = 0; i < errors.length; i++) {
        if (errors[i].textContent !== "") {
            hasError = true;
            break;
        }
    }

    if (!hasError) {
        let firstName = document.getElementById("firstName").value;
        let lastName = document.getElementById("lastName").value;
        let email = document.getElementById("email").value;
        let mobile = document.getElementById("mobileNo").value;

        alert(`Registration successful!\n\nName: ${firstName} ${lastName}\nEmail: ${email}\nMobile: ${mobile}`);
    } else {
        event.preventDefault();
    }
}

