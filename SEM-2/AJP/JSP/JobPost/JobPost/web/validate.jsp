<%-- 
    Document   : validate
    Created on : Jan 28, 2025, 10:49:32 PM
    Author     : angre
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String job = request.getParameter("job");

    boolean hasErrors = false;
    StringBuilder errors = new StringBuilder();

    if (name == null || name.trim().isEmpty()) {
        hasErrors = true;
        errors.append("<p class='error'>Name is required.</p>");
    }
    if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
        hasErrors = true;
        errors.append("<p class='error'>Valid email is required.</p>");
    }
    if (phone == null || !phone.matches("^\\d{10}$")) {
        hasErrors = true;
        errors.append("<p class='error'>Valid 10-digit phone number is required.</p>");
    }
    if (job == null || job.trim().isEmpty()) {
        hasErrors = true;
        errors.append("<p class='error'>Job role is required.</p>");
    }

    if (hasErrors) {
%>
<!DOCTYPE html>
<html>
<head>
    <title>Validation Errors</title>
</head>
<body>
    <h2>Validation Errors</h2>
    <%= errors.toString() %>
    <a href="index.html">Go Back</a>
</body>
</html>
<%
    } else {
%>
<!DOCTYPE html>
<html>
<head>
    <title>Application Successful</title>
</head>
<body>
    <h2>Application Submitted Successfully!</h2>
    <p>Thank you, <%= name %>. We will contact you at <%= email %> soon.</p>
</body>
</html>
<%
    }
%>

