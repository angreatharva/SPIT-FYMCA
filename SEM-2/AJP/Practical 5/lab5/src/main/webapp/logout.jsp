<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Remove the cookie
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("currentUser".equals(cookie.getName())) {
                cookie.setValue("");
                cookie.setMaxAge(0);
                response.addCookie(cookie);
                break;
            }
        }
    }

    // Invalidate the session
    session.invalidate();

    response.sendRedirect("login.jsp");
%>