<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // Predefined users (Can be replaced with file-based storage)
    java.util.HashMap<String, String> users = new java.util.HashMap<>();
    users.put("admin", "admin123");
    users.put("user1", "user1");
    users.put("user2", "user2");

    // Check if username exists and password matches
    if (users.containsKey(username) && users.get(username).equals(password)) {
        session.setAttribute("currentUser", username);
        session.setMaxInactiveInterval(3 * 60); 
        response.sendRedirect("homePage.jsp");
    } else {
        response.sendRedirect("login.jsp?error=true");
    }
%>