<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Success</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f3f4f6; text-align: center; padding: 50px; }
        .container { background: white; padding: 20px; border-radius: 8px; display: inline-block; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); }
        h2 { color: green; }
        .back-btn { margin-top: 20px; display: inline-block; padding: 10px 15px; background: #0072ff; color: white; text-decoration: none; border-radius: 5px; }
        .back-btn:hover { background: #0056d2; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Registration Successful!</h2>
        <p><strong>Name:</strong> <%= session.getAttribute("name") %></p>
        <p><strong>Email:</strong> <%= session.getAttribute("email") %></p>
        <a href="index.jsp" class="back-btn">Go Back</a>
    </div>
</body>
</html>
