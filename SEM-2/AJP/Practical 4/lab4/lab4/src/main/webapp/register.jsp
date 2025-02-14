<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirmPassword");
    String usernameError = "";
    String emailError = "";
    String passwordError = "";
    String confirmPasswordError = "";
    boolean hasErrors = false;

    if (request.getMethod().equals("POST")) {
        // Server-side validation
        if (username == null || username.trim().isEmpty()) {
            hasErrors = true;
            usernameError = "Username is required.";
        }
        if (email == null || !email.matches("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {
            hasErrors = true;
            emailError = "Valid email is required.";
        }
        if (password == null || password.length() < 6) {
            hasErrors = true;
            passwordError = "Password must be at least 6 characters long.";
        }
        if (confirmPassword == null || !confirmPassword.equals(password)) {
            hasErrors = true;
            confirmPasswordError = "Passwords do not match.";
        }

        if (!hasErrors) {
            // If validation passes, then forward to processing page
            request.getRequestDispatcher("registerProcess.jsp").forward(request, response);
            return;
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fa;
            padding: 2rem;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .form-container {
            max-width: 500px;
            width: 100%;
            margin: 0 auto;
            background: #fff;
            padding: 3rem;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #343a40;
            text-align: center;
            margin-bottom: 2rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        label {
            display: block;
            font-weight: 500;
            margin-bottom: 0.5rem;
            color: #495057;
        }

        input {
            width: 100%;
            padding: 1rem;
            border: 1px solid #ced4da;
            border-radius: 6px;
            font-size: 1rem;
            color: #495057;
            box-sizing: border-box;
        }

        input:focus {
            outline: none;
            border-color: #80bdff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }

        .error {
            color: #dc3545;
            font-size: 0.9rem;
            margin-top: 0.25rem;
        }

        button {
            background-color: #007bff;
            color: white;
            padding: 1rem 1.5rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            width: 100%;
            font-size: 1.1rem;
            transition: background-color 0.2s;
        }

        button:hover {
            background-color: #0056b3;
        }

        .login-link {
            text-align: center;
            margin-top: 2rem;
        }

        .login-link a {
            color: #007bff;
            text-decoration: none;
        }

        .login-link a:hover {
            text-decoration: underline;
        }
        .btn-primary {
                    background-color: #343a40;
                    color: #fff;
                    padding: 12px 20px;
                    border: none;
                    border-radius: 4px;
                    cursor: pointer;
                    width: 100%;
                    font-size: 16px;
                    transition: background-color 0.3s;
                }

                .btn-primary:hover {
                    background-color: #494E53;
                }
    </style>
    <script>
        function validateForm(event) {
            let hasErrors = false;

            // Clear previous errors
            document.querySelectorAll('.error').forEach(error => error.textContent = '');

            // Username validation
            const username = document.getElementById('username').value.trim();
            if (!username) {
                document.getElementById('usernameError').textContent = 'Username is required.';
                hasErrors = true;
            }

            // Email validation
            const email = document.getElementById('email').value.trim();
            const emailRegex = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;
            if (!email || !emailRegex.test(email)) {
                document.getElementById('emailError').textContent = 'Valid email is required.';
                hasErrors = true;
            }

            // Password validation
            const password = document.getElementById('password').value;
            if (!password || password.length < 6) {
                document.getElementById('passwordError').textContent = 'Password must be at least 6 characters long.';
                hasErrors = true;
            }

            // Confirm password validation
            const confirmPassword = document.getElementById('confirmPassword').value;
            if (password !== confirmPassword) {
                document.getElementById('confirmPasswordError').textContent = 'Passwords do not match.';
                hasErrors = true;
            }

            if (hasErrors) {
               event.preventDefault(); // Prevent form submission if there are errors
            }
        }
    </script>
</head>
<body>
    <div class="form-container">
        <h2>User Registration</h2>
        <form action="<%= request.getRequestURI() %>" method="POST" onsubmit="validateForm(event)">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" value="<%= username != null ? username : "" %>" placeholder="Enter username">
                <div class="error" id="usernameError"><%= usernameError %></div>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= email != null ? email : "" %>" placeholder="Enter your email">
                <div class="error" id="emailError"><%= emailError %></div>
            </div>

            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="Enter password">
                <div class="error" id="passwordError"><%= passwordError %></div>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirm Password:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm password">
                <div class="error" id="confirmPasswordError"><%= confirmPasswordError %></div>
            </div>

            <button type="submit" class="btn btn-primary">Register</button>

            <div class="login-link">
                Already have an account? <a href="login.jsp">Login here</a>
            </div>
        </form>
    </div>
</body>
</html>
