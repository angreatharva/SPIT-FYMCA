package com.example;

public class Loan {
    private int loanId;
    private String email;
    private double amount;
    private int tenure;
    private String purpose;
    private String status;

    public Loan() {
    }

    public Loan(int loanId, String email, double amount, int tenure, String purpose, String status) {
        this.loanId = loanId;
        this.email = email;
        this.amount = amount;
        this.tenure = tenure;
        this.purpose = purpose;
        this.status = status;
    }

    // Getters and setters
    public int getLoanId() {
        return loanId;
    }

    public void setLoanId(int loanId) {
        this.loanId = loanId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public int getTenure() {
        return tenure;
    }

    public void setTenure(int tenure) {
        this.tenure = tenure;
    }

    public String getPurpose() {
        return purpose;
    }

    public void setPurpose(String purpose) {
        this.purpose = purpose;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}