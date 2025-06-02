<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Marks Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            text-align: center;
        }
        
        h1 {
            color: #333;
            margin-bottom: 20px;
        }
        
        p {
            color: #666;
            margin-bottom: 30px;
        }
        
        .card-container {
            display: flex;
            justify-content: center;
            margin-top: 30px;
        }
        
        .card {
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 20px;
            margin: 0 15px;
            width: 100%;
            max-width: 400px;
        }
        
        .card-icon {
            font-size: 48px;
            margin-bottom: 15px;
            color: #4CAF50;
        }
        
        .card h2 {
            color: #333;
            margin-bottom: 15px;
        }
        
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            margin-top: 15px;
        }
        
        .btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Student Marks Management System</h1>
        <p>Welcome to the Student Marks Management System. Calculate and store student marks and percentages.</p>
        
        <div class="card-container">
            <div class="card">
                <div class="card-icon">➕</div>
                <h2>Calculate</h2>
                <p>Enter student details and marks to calculate percentage</p>
                <a href="register.jsp" class="btn">Calculate Percentage</a>
            </div>
        </div>
    </div>
</body>
</html>

