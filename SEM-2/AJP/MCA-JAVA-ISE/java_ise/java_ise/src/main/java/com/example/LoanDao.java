package com.example;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.example.Loan;
import com.example.DBConnection;

public class LoanDao {

    // Get all loans from the database
    public List<Loan> getAllLoans() {
        List<Loan> loanList = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM applications")) {

            while (rs.next()) {
                Loan loan = new Loan();
                loan.setLoanId(rs.getInt("loan_id"));
                loan.setEmail(rs.getString("email"));
                loan.setAmount(rs.getDouble("amount"));
                loan.setTenure(rs.getInt("tenure"));
                loan.setPurpose(rs.getString("purpose"));
                loan.setStatus(rs.getString("status"));

                loanList.add(loan);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return loanList;
    }

    // Get loans by status (Pending, Approved, Denied)
    public List<Loan> getLoansByStatus(String status) {
        List<Loan> loanList = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM applications WHERE status = ?")) {

            pstmt.setString(1, status);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Loan loan = new Loan();
                loan.setLoanId(rs.getInt("loan_id"));
                loan.setEmail(rs.getString("email"));
                loan.setAmount(rs.getDouble("amount"));
                loan.setTenure(rs.getInt("tenure"));
                loan.setPurpose(rs.getString("purpose"));
                loan.setStatus(rs.getString("status"));

                loanList.add(loan);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return loanList;
    }

    // Get a specific loan by ID
    public Loan getLoanById(int loanId) {
        Loan loan = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM applications WHERE loan_id = ?")) {

            pstmt.setInt(1, loanId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                loan = new Loan();
                loan.setLoanId(rs.getInt("loan_id"));
                loan.setEmail(rs.getString("email"));
                loan.setAmount(rs.getDouble("amount"));
                loan.setTenure(rs.getInt("tenure"));
                loan.setPurpose(rs.getString("purpose"));
                loan.setStatus(rs.getString("status"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return loan;
    }

    // Update loan status (Approve or Deny)
    public boolean updateLoanStatus(int loanId, String status) {
        boolean success = false;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement("UPDATE applications SET status = ? WHERE loan_id = ?")) {

            pstmt.setString(1, status);
            pstmt.setInt(2, loanId);

            int rowsAffected = pstmt.executeUpdate();
            success = (rowsAffected > 0);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return success;
    }
}