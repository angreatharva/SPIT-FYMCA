package com.example;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDao {

    public static User loginUser(String email, String password, String role) {
        User user = null;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE email = ? AND password = ? AND role = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);
            stmt.setString(3, role);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setName(rs.getString("name"));
                user.setEmail(email);
                user.setPassword(password);
                user.setRole(role);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public static boolean registerUser(String name, String email, String password, String role) {
        String sql = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) return false;

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, password);
            pstmt.setString(4, role);

            int rowsAffected = pstmt.executeUpdate();
            pstmt.close();
            return rowsAffected > 0;

        } catch (SQLException e) {
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

    public static boolean updateUser(String oldEmail, String newName, String newEmail, String newRole) {
        String sql = "UPDATE users SET name = ?, email = ?, role = ? WHERE email = ?";

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                System.out.println("Connection is null, cannot update user");
                return false;
            }

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, newName);
            pstmt.setString(2, newEmail);
            pstmt.setString(3, newRole);
            pstmt.setString(4, oldEmail);

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
