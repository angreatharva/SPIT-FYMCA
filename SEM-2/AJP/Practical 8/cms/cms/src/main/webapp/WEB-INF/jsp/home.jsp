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
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .container {
            width: 100%;
            max-width: 900px;
            padding: 20px;
        }
        .dashboard {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
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
        .user-info {
            float: right;
            text-align: right;
            color: #666;
        }
        .content-panel {
            margin-top: 30px;
            text-align: center;
        }
        .grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-top: 20px;
        }
        .card {
            background: #f9f9f9;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .card h3 {
            margin-bottom: 15px;
            color: #333;
        }
        .card-icon {
            font-size: 3em;
            color: #667eea;
            margin-bottom: 15px;
            display: block;
        }
        .card p {
            color: #666;
            margin-bottom: 15px;
        }
        .btn {
            background: #667eea;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 8px 16px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: background 0.3s ease;
        }
        .btn:hover {
            background: #764ba2;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="dashboard">
            <div class="user-info">
                <div id="username">Welcome, <span id="user-name">User</span></div>
                <a href="<c:url value='/api/users/logout'/>" class="logout-btn btn">Logout</a>
            </div>
            
            <h1 class="welcome-header">Job Portal Management System</h1>
            
            <div class="content-panel">
                <div class="grid">
                    <div class="card">
                        <div class="card-icon">➕</div>
                        <h3>Post a Job</h3>
                        <p>Add a new job posting with title, description, and requirements</p>
                        <a href="<c:url value='/jobs/post'/>" class="btn">Post Job</a>
                    </div>
                    
                    <div class="card">
                        <div class="card-icon">👁️</div>
                        <h3>View Jobs</h3>
                        <p>View all posted jobs and their applications</p>
                        <a href="<c:url value='/jobs/view'/>" class="btn">View All Jobs</a>
                    </div>
                    
                    <div class="card">
                        <div class="card-icon">🔄</div>
                        <h3>Update Job</h3>
                        <p>Update existing job information and requirements</p>
                        <a href="<c:url value='/jobs/update'/>" class="btn">Update Job</a>
                    </div>
                    
                    <div class="card">
                        <div class="card-icon">❌</div>
                        <h3>Delete Job</h3>
                        <p>Remove a job posting from the portal</p>
                        <a href="<c:url value='/jobs/delete'/>" class="btn">Delete Job</a>
                    </div>
                </div>
            </div>
            <div style="text-align: center; margin-top: 30px; font-size: 0.9em; color: #666;">
                Job Portal Management System © 2023
            </div>
        </div>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            // You could use AJAX to get the current user's info
            document.getElementById('user-name').textContent = 'Admin';
        });
    </script>
</body>
</html> 