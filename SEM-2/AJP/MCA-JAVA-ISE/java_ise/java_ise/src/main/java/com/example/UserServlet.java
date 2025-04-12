package com.example;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

public class UserServlet extends HttpServlet {

    private final Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        System.out.println("doPost method called in UserServlet");

        try {
            // Check if this is a login request
            String action = request.getParameter("action");

            if ("login".equals(action)) {
                System.out.println("Processing login action");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String role = request.getParameter("role");

                System.out.println("Login attempt - email: " + email + ", role: " + role);

                // Attempt to login
                User user = UserDao.loginUser(email, password, role);

                if (user != null) {
                    // Login successful, create session
                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);
                    System.out.println("Login successful for user: " + email);

                    // Redirect to index page
                    if (Objects.equals(role, "admin")){
                        response.sendRedirect("index.jsp");
                    } else if (Objects.equals(role, "manager")) {

                    } else if (Objects.equals(role, "employee")) {
                        response.sendRedirect("employee_view.jsp");
                    }
                    else if (Objects.equals(role, "user")) {

                    }
                    return;
                } else {
                    // Login failed
                    System.out.println("Login failed for user: " + email);
                    response.sendRedirect("login.jsp?error=1");
                    return;
                }
            } else {
                // This is a registration request
                response.setContentType("application/json");
                PrintWriter out = response.getWriter();

                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String role = request.getParameter("role");

                System.out.println("Received parameters - name: " + name + ", email: " + email + ", role: " + role);

                if (name == null || email == null || password == null || role == null ||
                        name.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty() || role.trim().isEmpty()) {
                    out.println("{\"message\": \"All fields (name, email, password, role) are required!\"}");
                    return;
                }

                boolean success = UserDao.registerUser(name, email, password, role);
                String message = success ? "User registered successfully!" : "Registration failed!";
                out.println("{\"message\": \"" + message + "\"}");
            }
        } catch (Exception e) {
            System.out.println("Error in doPost: " + e.getMessage());
            e.printStackTrace();
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.println("{\"message\": \"An error occurred: " + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        System.out.println("doGet method called in UserServlet");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            List<User> users = UserDao.getAllUsers();
            String json = gson.toJson(users);
            out.println(json);
        } catch (Exception e) {
            System.out.println("Error in doGet: " + e.getMessage());
            e.printStackTrace();
            out.println("{\"message\": \"An error occurred: " + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        System.out.println("doPut method called in UserServlet");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            String requestData = readRequestBody(request);
            System.out.println("Request data: " + requestData);

            Map<String, String> data = gson.fromJson(requestData, new TypeToken<Map<String, String>>() {}.getType());

            String oldEmail = data.get("oldEmail");
            String newName = data.get("name");
            String newEmail = data.get("email");
            String newRole = data.get("role");

            System.out.println("Updating user - oldEmail: " + oldEmail + ", newName: " + newName + ", newEmail: " + newEmail + ", newRole: " + newRole);

            boolean updated = UserDao.updateUser(oldEmail, newName, newEmail, newRole);
            String message = updated ? "User updated successfully!" : "User not found!";
            out.println("{\"message\": \"" + message + "\"}");
        } catch (Exception e) {
            System.out.println("Error in doPut: " + e.getMessage());
            e.printStackTrace();
            out.println("{\"message\": \"An error occurred: " + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        System.out.println("doDelete method called in UserServlet");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            String requestData = readRequestBody(request);
            System.out.println("Request data: " + requestData);

            Map<String, String> data = gson.fromJson(requestData, new TypeToken<Map<String, String>>() {}.getType());
            String email = data.get("email");

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
}