<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Percentage Result</title>
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
            margin-bottom: 30px;
        }
        
        .result-box {
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 20px;
            margin-bottom: 30px;
        }
        
        .percentage {
            font-size: 36px;
            font-weight: bold;
            color: #4CAF50;
            margin: 20px 0;
        }
        
        .success-message {
            color: #4CAF50;
            margin-bottom: 20px;
        }
        
        .error-message {
            color: #f44336;
            margin-bottom: 20px;
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
        }
        
        .btn:hover {
            background-color: #45a049;
        }
        
        .btn-secondary {
            background-color: #6c757d;
            margin-left: 10px;
        }
        
        .btn-secondary:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Percentage Calculation Result</h1>
        
        <% if (request.getAttribute("success") != null && (Boolean)request.getAttribute("success")) { %>
            <div class="success-message">
                Your information has been saved successfully!
            </div>
            
            <div class="result-box">
                <h2>Hello, <%= request.getAttribute("name") %>!</h2>
                <p>Your percentage is:</p>
                <div class="percentage">
                    <%= String.format("%.2f", (Double)request.getAttribute("percentage")) %>%
                </div>
            </div>
        <% } else { %>
            <div class="error-message">
                There was an error processing your information.
                <% if (request.getAttribute("error") != null) { %>
                    <br>
                    <%= request.getAttribute("error") %>
                <% } %>
            </div>
        <% } %>
        
        <div>
            <a href="register.jsp" class="btn">Calculate Another</a>
            <a href="index.jsp" class="btn btn-secondary">Home</a>
        </div>
    </div>
</body>
</html> 