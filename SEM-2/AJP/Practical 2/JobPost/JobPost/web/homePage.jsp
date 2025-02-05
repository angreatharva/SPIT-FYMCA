<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("register.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home Page</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: #333;
            background-color: #f5f5f5;
            padding: 2rem;
            text-align: center;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: #fff;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #2c5282;
        }
        .btn {
            display: inline-block;
            background-color: #2c5282;
            color: white;
            padding: 0.75rem 1.5rem;
            text-decoration: none;
            border-radius: 4px;
            margin-top: 1rem;
        }
        .btn:hover {
            background-color: #2b6cb0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Welcome, <%= username %>!</h2>
        <p>You have successfully registered.</p>
        <a href="jobApplication.jsp" class="btn">Apply for Job</a>
    </div>
</body>
</html>
