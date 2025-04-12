<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Application Management</title>
    <style>
        body {
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    background-color: #f7f9fc;
                    margin: 0;
                    padding: 0;
        }
        .main-container {
                    max-width: 1200px;
                    margin: 0 auto;
                    padding: 20px;
        }
        .container {
                            display:flex;
                            justify-content: space-around;

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



        .card {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            width: 300px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .card-container {
                    display: flex;
                    flex-wrap: wrap;
                    justify-content: space-around;
                    gap: 20px;
                }

        .icon {
            font-size: 48px;
            margin-bottom: 15px;
        }

        .view-icon {
            color: #3498db;
        }

        .approve-icon {
            color: #2ecc71;
        }

        .deny-icon {
            color: #e74c3c;
        }

        h2 {
            margin-top: 0;
            margin-bottom: 10px;
            color: #333;
        }

        p {
            color: #666;
            margin-bottom: 20px;
        }

        .btn {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }

        .btn:hover {
            background-color: #2980b9;
        }

        .footer {
            text-align: center;
            padding: 20px;
            margin-top: 40px;
            color: #777;
            border-top: 1px solid #ddd;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .status-pending {
            color: #f39c12;
            font-weight: bold;
        }

        .status-approved {
            color: #2ecc71;
            font-weight: bold;
        }

        .status-denied {
            color: #e74c3c;
            font-weight: bold;
        }

        .action-btn {
            padding: 6px 12px;
            border-radius: 4px;
            color: white;
            text-decoration: none;
            margin: 0 5px;
            display: inline-block;
        }

        .approve-btn {
            background-color: #2ecc71;
        }

        .deny-btn {
            background-color: #e74c3c;
        }
    </style>
</head>
<body>
<div class="main-container">
    <div class="header">
        <h1>Application Management</h1>
    </div>

    <div class="container">
        <div class="card">
            <div class="icon view-icon">👁️</div>
            <h2>View Application</h2>
            <p>View all requests and their current status in the system.</p>
            <a href="viewLoans.jsp" class="btn">View All Application</a>
        </div>

        <div class="card">
            <div class="icon approve-icon">✅</div>
            <h2>Approve / Deny</h2>
            <p>Review and approve / deny pending requests from users.</p>
            <a href="pendingLoans.jsp" class="btn">Pending Approvals</a>
        </div>

        <div class="card">
            <div class="icon deny-icon">❌</div>
            <h2>Record History</h2>
            <p>View complete history of record requests.</p>
            <a href="loanHistory.jsp" class="btn">View History</a>
        </div>
    </div>

    <div class="footer">
        <p>Application Management</p>
    </div>
<div class="container">
</body>
</html>