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
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            padding: 2rem;
        }
        .form-container {
            max-width: 600px;
            margin: 0 auto;
            background: #fff;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #2c5282;
            text-align: center;
        }
        label {
            font-weight: 600;
            display: block;
            margin-top: 0.5rem;
        }
        input {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #e2e8f0;
            border-radius: 4px;
            margin-bottom: 0.5rem;
        }
        .error {
            color: #e53e3e;
            font-size: 0.875rem;
        }
        button {
            background-color: #2c5282;
            color: white;
            padding: 0.75rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 1rem;
            width: 100%;
        }
        button:hover {
            background-color: #2b6cb0;
        }
    </style>
    <script>
        function validateForm(event) {
            event.preventDefault();
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
            
            if (!hasErrors) {
                event.target.submit();
            }
        }
    </script>
</head>
<body>
    <div class="form-container">
        <h2>User Registration</h2>
        <form action="<%= request.getRequestURI() %>" method="POST" onsubmit="validateForm(event)">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" value="<%= username != null ? username : "" %>" placeholder="Enter username">
            <div class="error" id="usernameError"><%= usernameError %></div>
            
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="<%= email != null ? email : "" %>" placeholder="Enter your email">
            <div class="error" id="emailError"><%= emailError %></div>
            
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" placeholder="Enter password">
            <div class="error" id="passwordError"><%= passwordError %></div>
            
            <label for="confirmPassword">Confirm Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm password">
            <div class="error" id="confirmPasswordError"><%= confirmPasswordError %></div>
            
            <button type="submit">Register</button>
        </form>
    </div>
</body>
</html>