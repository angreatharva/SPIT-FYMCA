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
    <title>Jobs - Job Portal</title>
</head>
<body>
    <h2>Available Jobs</h2>
    <ul>
        <li>Software Engineer
            <form method="post" action="apply.jsp">
                <input type="hidden" name="job" value="Software Engineer" />
                <input type="submit" value="Apply" />
            </form>
        </li>
        <li>Data Analyst
            <form method="post" action="apply.jsp">
                <input type="hidden" name="job" value="Data Analyst" />
                <input type="submit" value="Apply" />
            </form>
        </li>
        <li>Project Manager
            <form method="post" action="apply.jsp">
                <input type="hidden" name="job" value="Project Manager" />
                <input type="submit" value="Apply" />
            </form>
        </li>
    </ul>
    <a href="welcome.jsp">Back to Home</a> | <a href="logout.jsp">Logout</a>
</body>
</html> 