<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Users</title>
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
            margin-bottom: 20px;
        }
        .btn:hover {
            background-color: #2980b9;
        }
        .user-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .user-table th, .user-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .user-table th {
            background-color: #f2f2f2;
            color: #2c3e50;
            font-weight: 600;
        }
        .user-table tr:hover {
            background-color: #f5f5f5;
        }
        .empty-state {
            padding: 40px 20px;
            color: #7f8c8d;
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
            <div class="card-icon">👁️</div>
            <h2>View All Users</h2>

            <button class="btn" onclick="viewUsers()">Refresh Users List</button>

            <div id="usersList">
                <!-- User list will be populated here -->
            </div>
        </div>

        <div class="footer">
            <p>Servlet-based User Management System &copy; 2025</p>
        </div>
    </div>

    <script>
        // Load users when the page loads
        window.onload = viewUsers;

        function viewUsers() {
            fetch('register', { method: 'GET' })
                .then(response => response.json())
                .then(data => {
                    let usersList = document.getElementById('usersList');

                    if (data.length === 0) {
                        usersList.innerHTML = '<div class="empty-state">' +
                                              '<h3>No Users Found</h3>' +
                                              '<p>There are no users registered in the system yet.</p>' +
                                              '<p>Go to the Register page to add new users.</p>' +
                                              '</div>';
                    } else {
                        let tableHTML = '<table class="user-table">' +
                                        '<thead>' +
                                        '<tr>' +
                                        '<th>Name</th>' +
                                        '<th>Email</th>' +
                                        '</tr>' +
                                        '</thead>' +
                                        '<tbody>';

                        data.forEach(user => {
                            tableHTML += `<tr>
                                           <td>${user.name}</td>
                                           <td>${user.email}</td>
                                         </tr>`;
                        });

                        tableHTML += '</tbody></table>';
                        usersList.innerHTML = tableHTML;
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    document.getElementById('usersList').innerHTML =
                        '<div class="empty-state">' +
                        '<h3>Error</h3>' +
                        '<p>Failed to load users. Please try again later.</p>' +
                        '</div>';
                });
        }
    </script>
</body>
</html>