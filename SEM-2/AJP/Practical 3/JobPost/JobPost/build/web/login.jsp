<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Job Portal</title>
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
        .error {
            color: #e53e3e;
            margin-bottom: 1rem;
            text-align: center;
        }
        label {
            display: block;
            margin-top: 1rem;
        }
        input {
            width: 100%;
            padding: 0.75rem;
            margin-bottom: 1rem;
            border: 1px solid #e2e8f0;
            border-radius: 4px;
        }
        button {
            width: 100%;
            padding: 0.75rem;
            background-color: #2c5282;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #2b6cb0;
        }
        .register-link {
            text-align: center;
            margin-top: 1rem;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Login to Job Portal</h2>
        <% if (request.getParameter("error") != null) { %>
            <div class="error">Invalid username or password</div>
        <% } %>
        <form action="loginProcess.jsp" method="POST">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
            
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
            
            <button type="submit">Login</button>
        </form>
        <div class="register-link">
            Don't have an account? <a href="register.jsp">Register here</a>
        </div>
    </div>
</body>
</html>