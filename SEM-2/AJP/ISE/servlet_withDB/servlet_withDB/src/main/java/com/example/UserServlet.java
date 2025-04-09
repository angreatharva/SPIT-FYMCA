package com.example;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;

public class UserServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        System.out.println("doPost method called in UserServlet");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            System.out.println("Received parameters - name: " + name + ", email: " + email);

            // Validate inputs
            if (name == null || email == null || password == null ||
                    name.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty()) {
                out.println("{\"message\": \"All fields are required!\"}");
                return;
            }

            boolean success = UserDao.registerUser(name, email, password);
            String message = success ? "User registered successfully!" : "Registration failed!";
            out.println("{\"message\": \"" + message + "\"}");
        } catch (Exception e) {
            System.out.println("Error in doPost: " + e.getMessage());
            e.printStackTrace();
            out.println("{\"message\": \"An error occurred: " + e.getMessage() + "\"}");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        System.out.println("doGet method called in UserServlet");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            List<User> users = UserDao.getAllUsers();
            Gson gson = new Gson();
            String json = gson.toJson(users);
            out.println(json);
        } catch (Exception e) {
            System.out.println("Error in doGet: " + e.getMessage());
            e.printStackTrace();
            out.println("{\"message\": \"An error occurred: " + e.getMessage() + "\"}");
        }
    }

    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        System.out.println("doPut method called in UserServlet");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            String requestData = readRequestBody(request);
            System.out.println("Request data: " + requestData);

            String oldEmail = extractJsonValue(requestData, "oldEmail");
            String newName = extractJsonValue(requestData, "name");
            String newEmail = extractJsonValue(requestData, "email");

            System.out.println("Updating user - oldEmail: " + oldEmail + ", newName: " + newName + ", newEmail: " + newEmail);

            boolean updated = UserDao.updateUser(oldEmail, newName, newEmail);
            String message = updated ? "User updated successfully!" : "User not found!";
            out.println("{\"message\": \"" + message + "\"}");
        } catch (Exception e) {
            System.out.println("Error in doPut: " + e.getMessage());
            e.printStackTrace();
            out.println("{\"message\": \"An error occurred: " + e.getMessage() + "\"}");
        }
    }

    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        System.out.println("doDelete method called in UserServlet");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            String requestData = readRequestBody(request);
            System.out.println("Request data: " + requestData);

            String email = extractJsonValue(requestData, "email");
            System.out.println("Deleting user with email: " + email);

            boolean deleted = UserDao.deleteUser(email);
            String message = deleted ? "User deleted successfully!" : "User not found!";
            out.println("{\"message\": \"" + message + "\"}");
        } catch (Exception e) {
            System.out.println("Error in doDelete: " + e.getMessage());
            e.printStackTrace();
            out.println("{\"message\": \"An error occurred: " + e.getMessage() + "\"}");
        }
    }

    private String readRequestBody(HttpServletRequest request) throws IOException {
        BufferedReader reader = request.getReader();
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        return sb.toString().trim();
    }

    private String extractJsonValue(String json, String key) {
        String searchKey = "\"" + key + "\":\"";
        int startIndex = json.indexOf(searchKey);
        if (startIndex == -1) {
            return "";
        }
        startIndex += searchKey.length();
        int endIndex = json.indexOf("\"", startIndex);
        return endIndex == -1 ? "" : json.substring(startIndex, endIndex);
    }
}