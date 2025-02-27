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

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String sessionId = session.getId();
    int sessionTimeout = session.getMaxInactiveInterval();
    long lastAccessedTime = session.getLastAccessedTime();
    java.util.Date lastAccessedDate = new java.util.Date(lastAccessedTime);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Portal - Home</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            color: #333;
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

        /* Main Content */
        .container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h1 {
            color: #343a40;
            margin-bottom: 1.5rem;
        }

        .info {
            padding: 1.5rem;
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            margin-top: 1.5rem;
            text-align: left;
        }

        .info p {
            margin-bottom: 0.75rem;
        }

        /* Session Timeout Popup */
        .popup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 2rem;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
            border-radius: 8px;
            text-align: center;
            z-index: 1000;
        }

        .popup button {
            background: #007bff;
            color: white;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
            transition: background-color 0.2s ease;
        }

        .popup button:hover {
            background-color: #0056b3;
        }

        /* Footer */
        .footer {
            background: #343a40;
            color: white;
            text-align: center;
            padding: 1rem 0;
            position: fixed;
            width: 100%;
            bottom: 0;
            font-size: 0.9rem;
        }

        .footer a {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }

        /* Media Queries for Responsiveness */
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
    <script>
        setTimeout(function() {
            document.getElementById('sessionPopup').style.display = 'block';
        }, <%= sessionTimeout * 1000 %>);
    </script>
</head>
<body>
    <nav class="navbar">
        <a href="#">Home</a>
        <a href="jobApplication.jsp">Apply For Jobs</a>
        <a href="employers.jsp">Employers</a>
        <a href="#">About</a>
        <a href="logout.jsp">Logout</a>
    </nav>

    <div class="container">
        <h1>Welcome to the Job Portal</h1>
        <div class="info">
            <h2>Welcome, <%= user %>!</h2>
            <p><strong>Session ID:</strong> <%= sessionId %></p>
            <p><strong>Session Timeout:</strong> <%= sessionTimeout / 60 %> minutes</p>
            <p><strong>Last Accessed:</strong> <%= lastAccessedDate %></p>
        </div>
    </div>

    <footer class="footer">
        &copy; <%= java.time.Year.now().getValue() %> Job Portal. All rights reserved.
    </footer>

    <div id="sessionPopup" class="popup">
        <p>Your session has expired. Please log in again.</p>
        <button onclick="window.location.href='login.jsp'">Login Again</button>
    </div>
</body>
</html>
