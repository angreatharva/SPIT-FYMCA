<!DOCTYPE html>
<html>
<head>
    <title>Login - User Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
        }

        .header {
            background-color: #3498db;
            color: white;
            width: 100%;
            text-align: center;
            padding: 20px 0;
            margin-bottom: 40px;
        }

        .header h1 {
            margin: 0;
            font-size: 32px;
        }

        .card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            width: 350px;
            margin-bottom: 40px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }

        input[type="text"],
        input[type="password"],
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }

        .btn {
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 4px;
            padding: 12px 20px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #2980b9;
        }

        .footer {
            margin-top: auto;
            padding: 20px;
            color: #777;
            font-size: 14px;
            text-align: center;
        }

        .login-icon {
            text-align: center;
            margin-bottom: 20px;
        }

        .login-icon svg {
            width: 60px;
            height: 60px;
            fill: #3498db;
        }

        .card-title {
            text-align: center;
            margin-bottom: 25px;
            color: #333;
            font-size: 24px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>User Management System</h1>
    </div>

    <div class="card">
        <div class="login-icon">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/>
            </svg>
        </div>

        <h2 class="card-title">Login</h2>

        <form action="login" method="post">
            <input type="hidden" name="action" value="login" />

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="text" id="email" name="email" required />
            </div>

            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required />
            </div>

            <div class="form-group">
                <label for="role">Role:</label>
                <select id="role" name="role" required>
                    <option value="admin">Admin</option>
                    <option value="manager">Fund Manager</option>
                    <option value="employee">Client Service Executive</option>
                    <option value="user">User</option>
                </select>
            </div>

            <button type="submit" class="btn">Login</button>
        </form>
    </div>

    <div class="footer">
         User Management
    </div>
</body>
</html>