
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if user is logged in
    String username = (String) session.getAttribute("currentUser");
    if (username == null) {
        response.sendRedirect("login.jsp");
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

        body {
                    font-family: Arial, sans-serif;
                    background-color: #f8f9fa;
                    margin: 0;
                    padding: 0;
                }
                /* Navigation Bar */
                        .navbar {
                            background: #343a40; /* Dark Gray */
                            color: white;
                            padding: 1rem 0;
                            text-align: center;
                        }

                        .navbar a {
                            color: white;
                            text-decoration: none;
                            margin: 0 1.5rem;
                            font-weight: 500;
                            transition: color 0.3s ease;
                            display: inline-block;
                            padding: 0.5rem 1rem;
                            border-radius: 5px;
                        }

                        .navbar a:hover {
                            background-color: rgba(255, 255, 255, 0.1);
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
                .nav-bar-tabs {
                    background: #343a40;
                    color: white;
                    padding: 10px;
                    border: none;
                    border-radius: 5px;
                    cursor: pointer;
                    text-decoration: none;
                    display: inline-block;
                    margin-top: 15px;
                }
                .nav-bar-tabs:hover {
                    background: #343a40;
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
                @media (max-width: 768px) {
                            .navbar {
                                padding: 1rem;
                            }

                            .navbar a {
                                margin: 0 0.75rem;
                                padding: 0.4rem 0.75rem;
                            }

                            .container {
                                padding: 1.5rem;
                                margin: 1rem auto;
                            }

                            .info {
                                padding: 1rem;
                            }

                            .popup {
                                padding: 1.5rem;
                            }
                        }
    </style>
</head>
<body>
 <nav class="navbar">
         <a href="homePage.jsp">Home</a>
         <a href="jobApplication.jsp">Apply For Jobs</a>
         <a href="employers.jsp">Employers</a>
         <a href="#">About</a>
         <a href="logout.jsp">Logout</a>
     </nav>
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