<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #00c6ff, #0072ff);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            width: 340px;
            text-align: center;
        }
        h2 {
            color: #333;
        }
        input {
            width: 94%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }
        button {
            background: #0072ff;
            color: white;
            border: none;
            padding: 10px 15px;
            cursor: pointer;
            font-size: 18px;
            width: 100%;
            border-radius: 5px;
        }
        button:hover {
            background: #0056d2;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Register Here</h2>
        <form action="register" method="post">
            <input type="text" name="name" placeholder="Enter Name" required>
            <input type="email" name="email" placeholder="Enter Email" required>
            <input type="password" name="password" placeholder="Enter Password" required>
            <button type="submit">Register</button>
        </form>
    </div>
</body>
</html>
