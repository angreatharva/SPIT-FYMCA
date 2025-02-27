<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>

<%
    String user = (String) session.getAttribute("currentUser");

    // If user is not logged in via session, try checking cookies
    if (user == null) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("currentUser".equals(cookie.getName())) {
                    user = cookie.getValue();
                    if (user != null && !user.trim().isEmpty()) {
                        session.setAttribute("currentUser", user);
                    }
                    break;
                }
            }
        }
    }

    // If still no user, redirect to login
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Handle job posting submission
    String successMessage = "";
    if ("POST".equals(request.getMethod())) {
        String jobTitle = request.getParameter("jobTitle");
        String companyName = request.getParameter("companyName");
        String location = request.getParameter("location");
        String description = request.getParameter("description");
        String requirements = request.getParameter("requirements");

        if (jobTitle != null && companyName != null && !jobTitle.trim().isEmpty() && !companyName.trim().isEmpty()) {
            successMessage = "Job posting created successfully!";
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employers Portal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 0;
            background-color: #f4f6f9; /* Light gray background */
            color: #333;
        }

        /* Navbar */
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

        /* Container */
        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 1rem;
        }

        /* Section */
        .section {
            background-color: #fff;
            border-radius: 10px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05); /* Lighter shadow */
        }

        h1, h2 {
            color: #343a40;
            margin-bottom: 1.5rem;
        }

        /* Post Job Form */
        .post-job-form {
            display: grid;
            gap: 1.5rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #495057;
        }

        input,
        textarea {
            padding: 1rem;
            border: 1px solid #ced4da;
            border-radius: 6px;
            margin-bottom: 0.5rem;
            font-size: 1rem;
            color: #495057;
            box-sizing: border-box; /* Prevents padding from affecting width */
        }

        textarea {
            min-height: 120px;
        }

        input:focus,
        textarea:focus {
            outline: none;
            border-color: #80bdff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25); /* Focus effect */
        }

        button {
            background-color: #007bff;
            color: white;
            padding: 1rem 2rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
            font-size: 1.1rem;
            transition: background-color 0.3s ease; /* Smooth transition */
        }

        button:hover {
            background-color: #0056b3;
        }

        .success-message {
            color: #155724;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            padding: 1rem;
            border-radius: 6px;
            margin-bottom: 1.5rem;
        }

        /* Job Listing */
        .job-listing {
            border: 1px solid #dee2e6;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            border-radius: 8px;
            background-color: #f8f9fa;
        }

        .job-title {
            color: #343a40;
            margin: 0 0 0.75rem 0;
            font-size: 1.25rem;
        }

        .company-info {
            color: #6c757d;
            font-size: 0.9rem;
            margin-bottom: 1rem;
        }

        /* Stats */
        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            padding: 1.5rem;
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: #dc35455;
            margin-bottom: 0.5rem;
        }

        /* Logout Button */
        .logout-btn {
            //background: #dc3545;
        }

        .logout-btn:hover {
            background: #c82333;
        }
        .submit-btn{
        background: #343a40;
        }

        /* Media Queries for Responsiveness */
        @media (max-width: 768px) {
            .container {
                padding: 0.5rem;
            }

            .section {
                padding: 1.5rem;
            }

            .stats {
                grid-template-columns: 1fr; /* Stack on smaller screens */
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
        <a href="logout.jsp" class="logout-btn">Logout</a>
    </nav>

    <div class="container">
        <h1>Employers Portal</h1>

        <!-- Statistics Section -->
        <div class="stats">
            <div class="stat-card">
                <div class="stat-number">25</div>
                <div>Active Job Postings</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">142</div>
                <div>Total Applications</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">18</div>
                <div>Positions Filled</div>
            </div>
        </div>

        <!-- Post New Job Section -->
        <div class="section">
            <h2>Post a New Job</h2>
            <% if (!successMessage.isEmpty()) { %>
                <div class="success-message"><%= successMessage %></div>
            <% } %>
            <form class="post-job-form" method="POST" action="employers.jsp">
                <div class="form-group">
                    <label for="jobTitle">Job Title*</label>
                    <input type="text" id="jobTitle" name="jobTitle" required>
                </div>

                <div class="form-group">
                    <label for="companyName">Company Name*</label>
                    <input type="text" id="companyName" name="companyName" required>
                </div>

                <div class="form-group">
                    <label for="location">Location*</label>
                    <input type="text" id="location" name="location" required>
                </div>

                <div class="form-group">
                    <label for="description">Job Description*</label>
                    <textarea id="description" name="description" required></textarea>
                </div>

                <div class="form-group">
                    <label for="requirements">Requirements*</label>
                    <textarea id="requirements" name="requirements" required></textarea>
                </div>

                <button type="submit"class="submit-btn">Post Job</button>
            </form>
        </div>

        <!-- Current Job Listings Section -->
        <div class="section">
            <h2>Your Current Job Listings</h2>

            <div class="job-listing">
                <h3 class="job-title">Senior Software Engineer</h3>
                <div class="company-info">
                    <strong>Company:</strong> Tech Corp Inc. | <strong>Location:</strong> New York, NY
                </div>
                <p>Looking for an experienced software engineer to join our team...</p>
                <button onclick="alert('Feature coming soon!')" class="submit-btn">View Applications (12)</button>
            </div>

            <div class="job-listing">
                <h3 class="job-title">Product Manager</h3>
                <div class="company-info">
                    <strong>Company:</strong> Tech Corp Inc. | <strong>Location:</strong> Remote
                </div>
                <p>Seeking a talented product manager to lead our new initiative...</p>
                <button onclick="alert('Feature coming soon!')"class="submit-btn">View Applications (8)</button>
            </div>
        </div>
    </div>
</body>
</html>
