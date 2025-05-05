<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title}</title>
    <link rel="stylesheet" href="<c:url value='/css/styles.css'/>">
    <style>
        .dashboard {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            margin: 0 auto;
        }
        .welcome-header {
            margin-bottom: 20px;
            text-align: center;
            color: #333;
        }
        .logout-btn {
            margin-top: 20px;
            width: auto;
            padding: 8px 16px;
        }
        .nav-menu {
            margin: 20px 0;
            border-bottom: 1px solid #eee;
            display: flex;
        }
        .nav-item {
            padding: 10px 15px;
            color: #666;
            text-decoration: none;
            border-bottom: 2px solid transparent;
            margin-right: 10px;
        }
        .nav-item:hover, .nav-item.active {
            color: #764ba2;
            border-bottom-color: #764ba2;
        }
        .content-panel {
            margin-top: 20px;
        }
        .user-info {
            float: right;
            text-align: right;
            color: #666;
        }
        .grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-top: 20px;
        }
        .card {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 15px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        .card h3 {
            margin-bottom: 10px;
            color: #333;
        }
    </style>
</head>
<body>
    <div class="container" style="max-width: 900px;">
        <div class="dashboard">
            <div class="user-info">
                <div id="username">Welcome, <span id="user-name">User</span></div>
                <a href="<c:url value='/api/users/logout'/>" class="logout-btn btn" style="margin: 10px 0 0 0; display: inline-block;">Logout</a>
            </div>
            
            <h1 class="welcome-header">CMS Dashboard</h1>
            
            <div class="nav-menu">
                <a href="#" class="nav-item active">Dashboard</a>
                <a href="#" class="nav-item">Pages</a>
                <a href="#" class="nav-item">Media</a>
                <a href="#" class="nav-item">Users</a>
                <a href="#" class="nav-item">Settings</a>
            </div>
            
            <div class="content-panel">
                <p>Welcome to your Content Management System dashboard.</p>
                
                <div class="grid">
                    <div class="card">
                        <h3>Recent Activity</h3>
                        <p>No recent activity to display.</p>
                    </div>
                    <div class="card">
                        <h3>Quick Stats</h3>
                        <p>Pages: 0</p>
                        <p>Media Files: 0</p>
                        <p>Users: 1</p>
                    </div>
                    <div class="card">
                        <h3>Quick Links</h3>
                        <p><a href="#">Create New Page</a></p>
                        <p><a href="#">Upload Media</a></p>
                        <p><a href="#">Manage Users</a></p>
                    </div>
                    <div class="card">
                        <h3>System Status</h3>
                        <p>System is running normally.</p>
                        <p>Last backup: Never</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        // Fetch user data from sessionStorage or retrieve it from server
        document.addEventListener('DOMContentLoaded', () => {
            // You could use AJAX to get the current user's info
            // For now we'll just set a placeholder
            document.getElementById('user-name').textContent = 'Admin';
        });
    </script>
</body>
</html> 