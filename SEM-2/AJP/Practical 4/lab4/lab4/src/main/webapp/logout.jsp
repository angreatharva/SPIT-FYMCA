<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    session.invalidate();

    //javax.servlet.http.Cookie userCookie = new javax.servlet.http.Cookie("username", null);
    //userCookie.setMaxAge(0);
    //response.addCookie(userCookie);

    response.sendRedirect("login.jsp");
%>