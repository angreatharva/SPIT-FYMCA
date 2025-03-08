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

        out.println("<!DOCTYPE html>");
        out.println("<html lang='en'>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        out.println("<title>Registration Success</title>");
        out.println("<style>");
        out.println("body { font-family: Arial, sans-serif; background: #f3f4f6; text-align: center; padding: 50px; }");
        out.println(".container { background: white; padding: 20px; border-radius: 8px; display: inline-block; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); }");
        out.println("h2 { color: green; }");
        out.println("p { font-size: 18px; }");
        out.println(".back-btn { margin-top: 20px; display: inline-block; padding: 10px 15px; background: #0072ff; color: white; text-decoration: none; border-radius: 5px; }");
        out.println(".back-btn:hover { background: #0056d2; }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<div class='container'>");
        out.println("<h2>Registration Successful!</h2>");
        out.println("<p><strong>Name:</strong> " + name + "</p>");
        out.println("<p><strong>Email:</strong> " + email + "</p>");
        out.println("<a href='index.jsp' class='back-btn'>Go Back</a>");
        out.println("</div>");
        out.println("</body>");
        out.println("</html>");
    }
}
