<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String email = request.getParameter("email");

    // Basic validation
    if (username == null || username.trim().isEmpty() ||
        password == null || password.trim().isEmpty() ||
        email == null || email.trim().isEmpty()) {
        response.sendRedirect("register.jsp?error=Please fill all fields");
        return;
    }

    // Trim the inputs
    username = username.trim();
    password = password.trim();
    email = email.trim();

    // Email validation
    if (!email.matches("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {
        response.sendRedirect("register.jsp?error=Invalid email format");
        return;
    }

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

    // Check if username already exists
    if (users.containsKey(username)) {
        response.sendRedirect("register.jsp?error=Username already exists");
        return;
    }

    // Add the new user
    users.put(username, password);
    application.setAttribute("users", users);

    // Store user session
    session.setAttribute("currentUser", username);
    session.setMaxInactiveInterval(3 * 60);

    // Set a cookie to remember the user (expires in 1 week)
    javax.servlet.http.Cookie userCookie = new javax.servlet.http.Cookie("currentUser", username);
    userCookie.setMaxAge(60 * 60 * 24 * 7);
    response.addCookie(userCookie);

    response.sendRedirect("homePage.jsp");
%>