package com.example;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UserDao {
    public static boolean registerUser(String name, String email, String password) {
        boolean status = false;
        String query = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, password);

            int rows = stmt.executeUpdate();
            status = rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return status;
    }
}
