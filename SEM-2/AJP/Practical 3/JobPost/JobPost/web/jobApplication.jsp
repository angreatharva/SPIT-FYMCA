
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if user is logged in
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("register.jsp");
        return;
    }

    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String job = request.getParameter("job");
    String nameError = "";
    String emailError = "";
    String phoneError = "";
    String jobError = "";
    boolean hasErrors = false;
    
    if (request.getMethod().equals("POST")) {
        if (name == null || name.trim().isEmpty()) {
            hasErrors = true;
            nameError = "Name is required.";
        }
        if (email == null || !email.matches("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {
            hasErrors = true;
            emailError = "Valid email is required.";
        }
        if (phone == null || !phone.matches("^\\d{10}$")) {
            hasErrors = true;
            phoneError = "Valid 10-digit phone number is required.";
        }
        if (job == null || job.trim().isEmpty()) {
            hasErrors = true;
            jobError = "Job role is required.";
        }
    }
    
    if (!hasErrors && request.getMethod().equals("POST")) {
    
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Application Successful</title>
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
    </style>
</head>
<body>
    <div class="container">
         <h2>Application Submitted Successfully!</h2>
        <p>Thank you, <%= name %>. We will contact you at <%= email %> regarding your application for the <%= job %> position.</p>
        <a href="homePage.jsp" class="btn">Back to Home</a>
    </div>
</body>
</html>
<%
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Application Form</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: #333;
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
            margin-bottom: 1.5rem;
        }
        label {
            font-weight: 600;
            display: block;
            margin-top: 0.5rem;
        }
        input {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #e2e8f0;
            border-radius: 4px;
            margin-bottom: 0.5rem;
        }
        .error {
            color: #e53e3e;
            font-size: 0.875rem;
        }
        button {
            background-color: #2c5282;
            color: white;
            padding: 0.75rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 1rem;
            width: 100%;
        }
        button:hover {
            background-color: #2b6cb0;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Job Application</h2>
        <form action="jobApplication.jsp" method="POST">
            <label for="name">Full Name:</label>
            <input type="text" id="name" name="name" value="<%= name != null ? name : "" %>" placeholder="Enter your full name">
            <div class="error"><%= nameError %></div>
            
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="<%= email != null ? email : "" %>" placeholder="Enter your email">
            <div class="error"><%= emailError %></div>
            
            <label for="phone">Phone:</label>
            <input type="text" id="phone" name="phone" value="<%= phone != null ? phone : "" %>" placeholder="Enter your phone number">
            <div class="error"><%= phoneError %></div>
            
            <label for="job">Job Role:</label>
            <input type="text" id="job" name="job" value="<%= job != null ? job : "" %>" placeholder="Enter the job role">
            <div class="error"><%= jobError %></div>
            
            <button type="submit">Apply</button>
        </form>
    </div>
</body>
</html>