<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String job = request.getParameter("job");
    String nameError = "";
    String emailError = "";
    String phoneError = "";
    String jobError = "";
    boolean hasErrors = false;
    
    // Only check for errors if the form has been submitted
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
            margin: 0;
            padding: 2rem;
        }
        h2 {
            color: #2c5282;
            text-align: center;
            margin-bottom: 1.5rem;
        }
        p {
            text-align: center;
            font-size: 1.1rem;
            background: #fff;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 0 auto;
        }
    </style>
</head>
<body>
    <h2>Application Submitted Successfully!</h2>
    <p>Thank you, <%= name %>. We will contact you at <%= email %> soon.</p>
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
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

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
            font-size: 1.8rem;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        label {
            font-weight: 600;
            color: #4a5568;
            margin-bottom: 0.25rem;
            display: block;
        }

        input {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #e2e8f0;
            border-radius: 4px;
            font-size: 1rem;
            transition: border-color 0.2s ease;
            margin-bottom: 0.25rem;
        }

        input:focus {
            outline: none;
            border-color: #4299e1;
            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.1);
        }

        .error {
            color: #e53e3e;
            font-size: 0.875rem;
            margin-top: 0;
            min-height: 1rem;
        }

        button {
            background-color: #2c5282;
            color: white;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s ease;
            margin-top: 0.5rem;
        }

        button:hover {
            background-color: #2b6cb0;
        }

        @media (max-width: 480px) {
            body {
                padding: 1rem;
            }

            .form-container {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Job Application</h2>
        <form action="index.jsp" method="POST">
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