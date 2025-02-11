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
    session.setAttribute("currentUser", username);
    session.setMaxInactiveInterval(3 * 60);

    //Set a cookie to remember the user (expires in 1 week)
    javax.servlet.http.Cookie userCookie = new javax.servlet.http.Cookie("username", username);
    userCookie.setMaxAge(60 * 60 * 24 * 7);
    response.addCookie(userCookie);

    response.sendRedirect("homePage.jsp");


%>