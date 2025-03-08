package com.example;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        boolean success = UserDao.registerUser(name, email, password);

        out.println("<!DOCTYPE html>");
        out.println("<html lang='en'>");
        out.println("<head><meta charset='UTF-8'><title>Registration</title></head>");
        out.println("<body style='text-align:center;'>");

        if (success) {
            out.println("<h2 style='color:green;'>Registration Successful!</h2>");
            out.println("<p><strong>Name:</strong> " + name + "</p>");
            out.println("<p><strong>Email:</strong> " + email + "</p>");
        } else {
            out.println("<h2 style='color:red;'>Registration Failed!</h2>");
            out.println("<p>Email already exists or server issue.</p>");
        }
        out.println("<a href='index.jsp'>Go Back</a>");
        out.println("</body></html>");
    }
}
