<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update User</title>
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
            <div class="card-icon">🔄</div>
            <h2>Update User</h2>

            <div id="message" class="alert"></div>

            <form id="updateForm">
                <div class="form-group">
                    <label for="oldEmail">Current Email</label>
                    <input type="email" id="oldEmail" class="form-control" placeholder="Enter current email address" required>
                </div>

                <div class="form-group">
                    <label for="newName">New Name</label>
                    <input type="text" id="newName" class="form-control" placeholder="Enter new name" required>
                </div>

                <div class="form-group">
                    <label for="newEmail">New Email</label>
                    <input type="email" id="newEmail" class="form-control" placeholder="Enter new email address" required>
                </div>

                <button type="submit" class="btn">Update User</button>
            </form>
        </div>

        <div class="footer">
            <p>Servlet-based User Management System &copy; 2025</p>
        </div>
    </div>

    <script>
        document.getElementById('updateForm').addEventListener('submit', function(event) {
            event.preventDefault();

            const oldEmail = document.getElementById('oldEmail').value;
            const newName = document.getElementById('newName').value;
            const newEmail = document.getElementById('newEmail').value;
            const messageDiv = document.getElementById('message');

            fetch('register', {
                method: 'PUT',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ oldEmail, name: newName, email: newEmail })
            })
            .then(response => response.json())
            .then(data => {
                messageDiv.style.display = 'block';

                if (data.message.includes('successfully')) {
                    messageDiv.className = 'alert alert-success';
                    document.getElementById('updateForm').reset();
                } else {
                    messageDiv.className = 'alert alert-danger';
                }

                messageDiv.textContent = data.message;
            })
            .catch(error => {
                console.error('Error:', error);
                messageDiv.style.display = 'block';
                messageDiv.className = 'alert alert-danger';
                messageDiv.textContent = 'An error occurred. Please try again.';
            });
        });
    </script>
</body>
</html>