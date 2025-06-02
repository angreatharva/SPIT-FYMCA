<%@ page session="true" %>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome - Job Portal</title>
</head>
<body>
    <h2>Welcome, <%= user %>!</h2>
    <a href="jobs.jsp">View Jobs</a> | <a href="logout.jsp">Logout</a>
</body>
</html> 