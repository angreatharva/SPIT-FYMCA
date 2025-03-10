<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>

<%
    String user = (String) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
    }
    String sessionId = session.getId();
    int sessionTimeout = session.getMaxInactiveInterval();
    long lastAccessedTime = session.getLastAccessedTime();
    java.util.Date lastAccessedDate = new java.util.Date(lastAccessedTime);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Job Portal - Home</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .navbar {
            background: #2c5282;
            padding: 15px;
            text-align: center;
        }
        .navbar a {
            color: white;
            margin: 0 15px;
            text-decoration: none;
            font-weight: bold;
        }
        .container {
            text-align: center;
            padding: 50px;
        }
        .info {
            background: #fff;
            padding: 20px;
            width: 50%;
            margin: auto;
            border-radius: 8px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        .logout-btn {
            background: #2c5282;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin-top: 15px;
        }
        .logout-btn:hover {
            background: #2b6cb0;
        }
        .footer {
            background: #2c5282;
            color: white;
            text-align: center;
            padding: 15px;
            position: fixed;
            width: 100%;
            bottom: 0;
            font-size: 14px;
        }
        .footer a {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }
        .popup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
            border-radius: 5px;
            text-align: center;
        }
        .popup button {
            background: #2c5282;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
    <script>
        setTimeout(function() {
            document.getElementById('sessionPopup').style.display = 'block';
        }, <%= sessionTimeout * 1000 %>);
    </script>
</head>
<body>
    <div class="navbar">
        <a href="#">Home</a>
        <a href="jobApplication.jsp"class="logout-btn">Apply For Jobs</a>
        <a href="#">Employers</a>
        <a href="#">Applicants</a>
        <a href="#">About</a>
        <a href="logout.jsp" class="logout-btn">Logout</a>
    </div>
    <div class="container">
        <h1>Welcome to the Job Portal</h1>
        <div class="info">
            <h2>Welcome, <%= user %>!</h2>
            <p><strong>Session ID:</strong> <%= sessionId %></p>
            <p><strong>Session Timeout:</strong> <%= sessionTimeout / 60 %> minutes</p>
            <p><strong>Last Accessed:</strong> <%= lastAccessedDate %></p>
        </div>
    </div>
    
    <div id="sessionPopup" class="popup">
        <p>Your session has expired. Please log in again.</p>
        <button onclick="window.location.href='login.jsp'">Login Again</button>
    </div>
</body>
</html>
