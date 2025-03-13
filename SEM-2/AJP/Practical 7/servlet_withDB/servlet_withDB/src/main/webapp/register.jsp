<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register User</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f7f9fc;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .header {
            background-color: #3498db;
            color: white;
            padding: 20px 0;
            text-align: center;
            border-radius: 8px 8px 0 0;
            margin-bottom: 30px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .header h1 {
            margin: 0;
        }
        .nav {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }
        .nav a {
            display: inline-block;
            padding: 10px 15px;
            margin: 0 5px 10px 5px;
            background-color: white;
            color: #3498db;
            text-decoration: none;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            transition: all 0.3s;
        }
        .nav a:hover {
            background-color: #3498db;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 6px rgba(0,0,0,0.15);
        }
        .card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            padding: 30px;
            max-width: 500px;
            margin: 0 auto 30px auto;
            text-align: center;
        }
        .card-icon {
            font-size: 64px;
            margin-bottom: 15px;
            color: #3498db;
        }
        .card h2 {
            color: #2c3e50;
            margin: 0 0 25px 0;
        }
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #2c3e50;
            font-weight: 500;
        }
        .form-control {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        .form-control:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
        }
        .btn {
            display: inline-block;
            background-color: #3498db;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            transition: background-color 0.3s;
            width: 100%;
        }
        .btn:hover {
            background-color: #2980b9;
        }
        .alert {
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
            color: white;
            display: none;
        }
        .alert-success {
            background-color: #2ecc71;
        }
        .alert-danger {
            background-color: #e74c3c;
        }
        .footer {
            text-align: center;
            margin-top: 40px;
            padding: 20px;
            color: #7f8c8d;
            border-top: 1px solid #e0e0e0;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>User Management System</h1>
        </div>

        <div class="nav">
            <a href="index.jsp">Home</a>
            <a href="register.jsp">Register</a>
            <a href="view.jsp">View Users</a>
            <a href="update.jsp">Update User</a>
            <a href="delete.jsp">Delete User</a>
        </div>

        <div class="card">
            <div class="card-icon">➕</div>
            <h2>Register New User</h2>

            <div id="message" class="alert"></div>

            <form id="registerForm">
                <div class="form-group">
                    <label for="name">Full Name</label>
                    <input type="text" id="name" name="name" class="form-control" placeholder="Enter your full name" required>
                </div>

                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" class="form-control" placeholder="Enter your email address" required>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" class="form-control" placeholder="Create a password" required>
                </div>

                <button type="submit" class="btn">Register User</button>
            </form>
        </div>

        <div class="footer">
            <p>Servlet-based User Management System &copy; 2025</p>
        </div>
    </div>

    <script>
        // Check if there's a message parameter in the URL
        const urlParams = new URLSearchParams(window.location.search);
        const message = urlParams.get('message');
        const messageDiv = document.getElementById('message');

        if (message) {
            messageDiv.style.display = 'block';
            if (message.includes('successfully')) {
                messageDiv.className = 'alert alert-success';
            } else {
                messageDiv.className = 'alert alert-danger';
            }
            messageDiv.textContent = decodeURIComponent(message);
        }

        // For AJAX form submission
        document.getElementById('registerForm').addEventListener('submit', function(event) {
            event.preventDefault();

            console.log("Form submission started");

            // Clear previous messages
            messageDiv.style.display = 'none';

            // Get form values
            const name = document.getElementById('name').value.trim();
            const email = document.getElementById('email').value.trim();
            const password = document.getElementById('password').value;

            // Simple validation
            if (!name || !email || !password) {
                messageDiv.style.display = 'block';
                messageDiv.className = 'alert alert-danger';
                messageDiv.textContent = 'All fields are required!';
                return;
            }

            console.log("Sending data - name: " + name + ", email: " + email);

            // Create a URL-encoded string from the form data
            const formData = new FormData(this);
            const urlEncodedData = new URLSearchParams(formData).toString();
            console.log("Form data: " + urlEncodedData);

            // Show loading state
            const submitBtn = this.querySelector('button[type="submit"]');
            const originalBtnText = submitBtn.textContent;
            submitBtn.textContent = 'Processing...';
            submitBtn.disabled = true;

            fetch('register', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                    'Accept': 'application/json'
                },
                body: urlEncodedData
            })
            .then(response => {
                // Log response status for debugging
                console.log('Response status:', response.status);
                console.log('Response headers:', response.headers);
                return response.json();
            })
            .then(data => {
                // Log data for debugging
                console.log('Response data:', data);

                messageDiv.style.display = 'block';
                if (data.message && data.message.includes('successfully')) {
                    messageDiv.className = 'alert alert-success';
                    document.getElementById('registerForm').reset();
                } else {
                    messageDiv.className = 'alert alert-danger';
                }
                messageDiv.textContent = data.message || 'Unknown error occurred';
            })
            .catch(error => {
                console.error('Error details:', error);
                messageDiv.style.display = 'block';
                messageDiv.className = 'alert alert-danger';
                messageDiv.textContent = 'An error occurred. Please try again.';
            })
            .finally(() => {
                // Restore button state
                submitBtn.textContent = originalBtnText;
                submitBtn.disabled = false;
                console.log("Form submission complete");
            });
        });
    </script>
</body>
</html>