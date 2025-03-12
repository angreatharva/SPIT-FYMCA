package com.example;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Iterator;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RegisterServlet extends HttpServlet {

    private static ArrayList<User> users = new ArrayList<>();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String message;
        if (name == null || email == null || password == null) {
            message = "Invalid input!";
        } else {
            users.add(new User(name, email, password));
            message = "User registered successfully!";
        }

        // Check if the request accepts JSON (from fetch API) or needs redirection (from form submission)
        String acceptHeader = request.getHeader("Accept");
        if (acceptHeader != null && acceptHeader.contains("application/json")) {
            // Return JSON response for fetch API calls
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.println("{\"message\": \"" + message + "\"}");
        } else {
            // Redirect back to register page with message for form submissions
            response.sendRedirect("register.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        out.print("[");
        for (int i = 0; i < users.size(); i++) {
            User user = users.get(i);
            out.print("{\"name\":\"" + user.getName() + "\", \"email\":\"" + user.getEmail() + "\"}");
            if (i < users.size() - 1) {
                out.print(",");
            }
        }
        out.print("]");
    }

    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String requestData = readRequestBody(request);
        if (requestData.isEmpty()) {
            out.println("{\"message\": \"Invalid input!\"}");
            return;
        }

        String oldEmail = extractJsonValue(requestData, "oldEmail");
        String newName = extractJsonValue(requestData, "name");
        String newEmail = extractJsonValue(requestData, "email");

        boolean updated = false;
        for (User user : users) {
            if (user.getEmail().equals(oldEmail)) {
                user.setName(newName);
                user.setEmail(newEmail);
                updated = true;
                break;
            }
        }

        out.println(updated ? "{\"message\": \"User updated successfully!\"}" :
                "{\"message\": \"User not found!\"}");
    }

    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String requestData = readRequestBody(request);
        if (requestData.isEmpty()) {
            out.println("{\"message\": \"Invalid input!\"}");
            return;
        }

        String email = extractJsonValue(requestData, "email");

        Iterator<User> iterator = users.iterator();
        boolean deleted = false;
        while (iterator.hasNext()) {
            User user = iterator.next();
            if (user.getEmail().equals(email)) {
                iterator.remove();
                deleted = true;
                break;
            }
        }

        out.println(deleted ? "{\"message\": \"User deleted successfully!\"}" :
                "{\"message\": \"User not found!\"}");
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