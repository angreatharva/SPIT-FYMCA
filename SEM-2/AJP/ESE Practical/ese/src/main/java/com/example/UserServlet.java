package com.example;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private static final String JDBC_URL = "jdbc:mysql://:3306/student_db";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "Athanee@08";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String dobStr = request.getParameter("dob");
        String courseName = request.getParameter("courseName");
        
        int marks1 = Integer.parseInt(request.getParameter("marks1"));
        int marks2 = Integer.parseInt(request.getParameter("marks2"));
        int marks3 = Integer.parseInt(request.getParameter("marks3"));
        
        double percentage = (marks1 + marks2 + marks3) / 3.0;
        
        Date dob = Date.valueOf(dobStr);
        
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            
            String sql = "INSERT INTO students (name, dob, course_name, Java, DAA, Devops, percentage) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";
            
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setDate(2, dob);
            stmt.setString(3, courseName);
            stmt.setInt(4, marks1);
            stmt.setInt(5, marks2);
            stmt.setInt(6, marks3);
            stmt.setDouble(7, percentage);
            
            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;
            
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        request.setAttribute("success", success);
        if (success) {
            request.setAttribute("name", name);
            request.setAttribute("percentage", percentage);
        }
        
        request.getRequestDispatcher("result.jsp").forward(request, response);
    }
}