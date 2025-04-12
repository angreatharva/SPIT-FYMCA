<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.LoanDao,com.example.Loan, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View All Application</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }

        .header {
            background-color: #3498db;
            color: white;
            text-align: center;
            padding: 20px;
            margin-bottom: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        h2 {
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            margin-bottom: 40px;
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

        .btn {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin-bottom: 20px;
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
    </style>
</head>
<body>
    <%
        LoanDao loanDao = new LoanDao();
        List<Loan> loanList = loanDao.getAllLoans();
    %>

    <div class="header">
        <h1>Application Management</h1>
    </div>

    <div class="container">
        <a href="employee_view.jsp" class="btn">Back to Dashboard</a>

        <h2>All Loan Requests</h2>

        <% if(loanList.isEmpty()) { %>
            <p>No loan requests found in the system.</p>
        <% } else { %>
            <table>
                <thead>
                    <tr>
                        <th>Loan ID</th>
                        <th>Email</th>
                        <th>Amount ($)</th>
                        <th>Tenure (months)</th>
                        <th>Purpose</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% for(Loan loan : loanList) { %>
                        <tr>
                            <td><%= loan.getLoanId() %></td>
                            <td><%= loan.getEmail() %></td>
                            <td>₹<%= String.format("%.2f", loan.getAmount()) %></td>
                            <td><%= loan.getTenure() %></td>
                            <td><%= loan.getPurpose() %></td>
                            <td class="status-<%= loan.getStatus().toLowerCase() %>"><%= loan.getStatus() %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>
    </div>

    <div class="footer">
        <p>Application Management </p>
    </div>
</body>
</html>