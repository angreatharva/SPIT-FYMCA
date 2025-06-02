<%@ page session="true" %>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String job = request.getParameter("job");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Apply - Job Portal</title>
</head>
<body>
    <h2>Application Confirmation</h2>
    <p>Thank you, <%= user %>, for applying to <%= job %>!</p>
    <a href="jobs.jsp">Back to Jobs</a> | <a href="logout.jsp">Logout</a>
</body>
</html> 