package com.example;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDao {

    public static boolean registerUser(String name, String email, String password) {
        System.out.println("Attempting to register user: " + email);
        String sql = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                System.out.println("Connection is null, cannot register user");
                return false;
            }

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, password);  // In a real app, you should hash this password

            int rowsAffected = pstmt.executeUpdate();
            System.out.println("User registration result, rows affected: " + rowsAffected);
            pstmt.close();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("SQL Error during registration: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public static List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT name, email, password FROM users";

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                System.out.println("Connection is null, cannot get users");
                return users;
            }

            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                users.add(user);
            }

            rs.close();
            pstmt.close();

        } catch (SQLException e) {
            System.out.println("Error getting users: " + e.getMessage());
            e.printStackTrace();
        }

        return users;
    }

    public static boolean updateUser(String oldEmail, String newName, String newEmail) {
        String sql = "UPDATE users SET name = ?, email = ? WHERE email = ?";

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                System.out.println("Connection is null, cannot update user");
                return false;
            }

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, newName);
            pstmt.setString(2, newEmail);
            pstmt.setString(3, oldEmail);

            int rowsAffected = pstmt.executeUpdate();
            pstmt.close();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error updating user: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public static boolean deleteUser(String email) {
        String sql = "DELETE FROM users WHERE email = ?";

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                System.out.println("Connection is null, cannot delete user");
                return false;
            }

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);

            int rowsAffected = pstmt.executeUpdate();
            pstmt.close();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error deleting user: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
