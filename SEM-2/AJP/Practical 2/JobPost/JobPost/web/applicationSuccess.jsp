<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String currentUser = (String) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String name = (String) session.getAttribute("application_name_" + currentUser);
    String email = (String) session.getAttribute("application_email_" + currentUser);
    String job = (String) session.getAttribute("application_job_" + currentUser);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Application Successful</title>
    <style>
        /* Keep your existing styles */
    </style>
</head>
<body>
    <div class="container">
        <h2>Application Submitted Successfully!</h2>
        <p>Thank you, <%= name %>. We will contact you at <%= email %> regarding your application for the <%= job %> position.</p>
        <a href="index.jsp" class="btn">Back to Home</a>
    </div>
</body>
</html>