<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    System.out.println("getParameter currentUser"+ username);

    
    // Get stored password from session
    String storedPassword = (String) session.getAttribute("password_" + password);
    System.out.println("Login currentUser"+ username);
    System.out.println("Login currentUser"+ password);
    System.out.println("Login storedPassword"+ storedPassword);
    
    if (storedPassword != null && storedPassword.equals(password)) {
        // Set current user in session
        session.setAttribute("currentUser", username);
        
        response.sendRedirect("homePage.jsp");
    } else {
        response.sendRedirect("login.jsp?error=true");
    }
%>