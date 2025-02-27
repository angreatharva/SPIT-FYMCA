<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // Basic validation
    if (username == null || username.trim().isEmpty() ||
        password == null || password.trim().isEmpty()) {
        response.sendRedirect("login.jsp?error=Please fill all fields");
        return;
    }

    // Trim the inputs
    username = username.trim();
    password = password.trim();

    // Get the application-wide user store
    @SuppressWarnings("unchecked")
    java.util.HashMap<String, String> users = (java.util.HashMap<String, String>)
        application.getAttribute("users");

    // Initialize if not exists
    if(users == null) {
        users = new java.util.HashMap<>();
        users.put("admin", "admin123");
        application.setAttribute("users", users);
    }

    // Check if username exists and password matches
    if (users.containsKey(username) && users.get(username).equals(password)) {
        session.setAttribute("currentUser", username);
        session.setMaxInactiveInterval(3 * 60);

        javax.servlet.http.Cookie userCookie = new javax.servlet.http.Cookie("currentUser", username);
        userCookie.setMaxAge(60 * 60 * 24 * 7); // 1 week
        response.addCookie(userCookie);

        response.sendRedirect("homePage.jsp");
    } else {
        response.sendRedirect("login.jsp?error=true");
    }
%>