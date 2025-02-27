<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Job Portal</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .login-container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 400px;
            max-width: 90%;
        }
        .login-form {
            padding: 30px;
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .remember-me {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .remember-me input[type="checkbox"] {
            width: auto;
            margin: 0;
        }

        .remember-me label {
            margin: 0;
            font-size: 14px;
            color: #555;
            cursor: pointer;
        }
        label {
            display: block;
            font-size: 16px;
            color: #555;
            margin-bottom: 8px;
        }
        .form-control {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .form-control:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
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
        .register-link {
            text-align: center;
            margin-top: 20px;
        }
        .register-link a {
            color: #007bff;
            text-decoration: none;
        }
        .register-link a:hover {
            text-decoration: underline;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-form">
            <h2>Login to Job Portal</h2>
            <%
                if (request.getParameter("error") != null) {
            %>
                <div class="error">Invalid username or password</div>
            <%
                }

                // Check for cookies to pre-fill the form
                String savedUsername = "";
                String savedPassword = "";
                Cookie[] cookies = request.getCookies();
                if (cookies != null) {
                    for (Cookie cookie : cookies) {
                        if ("savedUsername".equals(cookie.getName())) {
                            savedUsername = cookie.getValue();
                        }
                        if ("savedPassword".equals(cookie.getName())) {
                            savedPassword = cookie.getValue();
                        }
                    }
                }
            %>
            <form action="loginProcess.jsp" method="POST">
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username" class="form-control" value="<%= savedUsername %>" required>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" class="form-control" value="<%= savedPassword %>" required>
                </div>
                <div class="form-group remember-me">
                    <input type="checkbox" id="rememberMe" name="rememberMe" <%= (!savedUsername.isEmpty()) ? "checked" : "" %> >
                    <label for="rememberMe">Remember Me</label>
                </div>
                <button type="submit" class="btn-primary">Login</button>
            </form>
            <div class="register-link">
                Don't have an account? <a href="register.jsp">Register here</a>
            </div>
        </div>
    </div>
</body>
</html>
