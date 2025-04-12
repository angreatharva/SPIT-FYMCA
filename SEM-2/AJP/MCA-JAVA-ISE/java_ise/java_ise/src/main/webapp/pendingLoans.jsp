<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.LoanDao,com.example.Loan, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pending Application Approvals</title>
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

        .message {
            padding: 10px;
            margin: 20px 0;
            border-radius: 4px;
        }

        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
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

        .action-btn {
            padding: 6px 12px;
            border-radius: 4px;
            color: white;
            border: none;
            cursor: pointer;
            margin: 0 5px;
        }

        .approve-btn {
            background-color: #2ecc71;
        }

        .approve-btn:hover {
            background-color: #27ae60;
        }

        .deny-btn {
            background-color: #e74c3c;
        }

        .deny-btn:hover {
            background-color: #c0392b;
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
        List<Loan> pendingLoans = loanDao.getLoansByStatus("Pending");

        String message = (String) session.getAttribute("message");
        if(message != null) {
            session.removeAttribute("message");
        }
    %>

    <div class="header">
        <h1>Loan Management</h1>
    </div>

    <div class="container">
        <a href="employee_view.jsp" class="btn">Back to Dashboard</a>

        <h2>Pending Loan Approvals</h2>

        <% if(message != null) { %>
            <div class="message success">
                <%= message %>
            </div>
        <% } %>

        <% if(pendingLoans.isEmpty()) { %>
            <p>No pending loan requests at this time.</p>
        <% } else { %>
            <table>
                <thead>
                    <tr>
                        <th>Loan ID</th>
                        <th>Email</th>
                        <th>Amount ($)</th>
                        <th>Tenure (months)</th>
                        <th>Purpose</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for(Loan loan : pendingLoans) { %>
                        <tr>
                            <td><%= loan.getLoanId() %></td>
                            <td><%= loan.getEmail() %></td>
                            <td>₹<%= String.format("%.2f", loan.getAmount()) %></td>
                            <td><%= loan.getTenure() %></td>
                            <td><%= loan.getPurpose() %></td>
                            <td>
                                <form action="LoanServlet" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="approve">
                                    <input type="hidden" name="loanId" value="<%= loan.getLoanId() %>">
                                    <button type="submit" class="action-btn approve-btn">Approve</button>
                                </form>

                                <form action="LoanServlet" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="deny">
                                    <input type="hidden" name="loanId" value="<%= loan.getLoanId() %>">
                                    <button type="submit" class="action-btn deny-btn">Deny</button>
                                </form>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>
    </div>

    <div class="footer">
        <p>Application Management</p>
    </div>
</body>
</html>