<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management System</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f7f9fc;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .header {
            background-color: #3498db;
            color: white;
            padding: 20px 0;
            text-align: center;
            border-radius: 8px 8px 0 0;
            margin-bottom: 30px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .header h1 {
            margin: 0;
        }
        .card-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            gap: 20px;
        }
        .card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            padding: 20px;
            width: 220px;
            text-align: center;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }
        .card-icon {
            font-size: 64px;
            margin-bottom: 15px;
            color: #3498db;
        }
        .card h2 {
            color: #2c3e50;
            margin: 0 0 15px 0;
        }
        .card p {
            color: #7f8c8d;
            margin-bottom: 20px;
            min-height: 60px;
        }
        .btn {
            display: inline-block;
            background-color: #3498db;
            color: white;
            padding: 10px 20px;
            border-radius: 4px;
            text-decoration: none;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #2980b9;
        }
        .footer {
            text-align: center;
            margin-top: 40px;
            padding: 20px;
            color: #7f8c8d;
            border-top: 1px solid #e0e0e0;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>User Management System</h1>
        </div>

        <div class="card-container">
            <div class="card">
                <div class="card-icon">➕</div>
                <h2>Register</h2>
                <p>Add a new user to the system with name, email, and password.</p>
                <a href="register.jsp" class="btn">Register User</a>
            </div>

            <div class="card">
                <div class="card-icon">👁️</div>
                <h2>View Users</h2>
                <p>View all registered users and their information in the system.</p>
                <a href="view.jsp" class="btn">View All Users</a>
            </div>

            <div class="card">
                <div class="card-icon">🔄</div>
                <h2>Update User</h2>
                <p>Update existing user information such as name and email.</p>
                <a href="update.jsp" class="btn">Update User</a>
            </div>

            <div class="card">
                <div class="card-icon">❌</div>
                <h2>Delete User</h2>
                <p>Remove a user from the system using their email address.</p>
                <a href="delete.jsp" class="btn">Delete User</a>
            </div>
        </div>

        <div class="footer">
            <p>Servlet-based User Management System &copy; 2025</p>
        </div>
    </div>
</body>
</html>