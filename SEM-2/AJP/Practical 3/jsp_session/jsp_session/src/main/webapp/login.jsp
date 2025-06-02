<%@ page import="java.io.*" %>
<%@ page session="true" %>
<%
    String error = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        if ("admin".equals(username) && "password".equals(password)) {
            session.setAttribute("user", username);
            response.sendRedirect("welcome.jsp");
            return;
        } else {
            error = "Invalid username or password";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Job Portal</title>
</head>
<body>
    <h2>Login</h2>
    <form method="post" action="login.jsp">
        <label>Username:</label>
        <input type="text" name="username" required /><br/><br/>
        <label>Password:</label>
        <input type="password" name="password" required /><br/><br/>
        <input type="submit" value="Login" />
    </form>
    <p style="color:red;"><%= error %></p>
</body>
</html> 