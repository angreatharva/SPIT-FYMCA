<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String email = request.getParameter("email");

    if (username == null || username.trim().isEmpty() || 
        password == null || password.trim().isEmpty() || 
        email == null || email.trim().isEmpty()) {
        response.sendRedirect("register.jsp?error=Please fill all fields");
        return;
    }

    // Store user session
    session.setAttribute("username", username);
    response.sendRedirect("homePage.jsp");
%>