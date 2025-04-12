package com.example;
import com.example.LoanDao;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/LoanServlet")
public class LoanServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private LoanDao loanDAO;

    public void init() {
        loanDAO = new LoanDao();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "approve":
                    approveLoan(request, response);
                    break;
                case "deny":
                    denyLoan(request, response);
                    break;
                default:
                    response.sendRedirect("index.jsp");
                    break;
            }
        } else {
            response.sendRedirect("index.jsp");
        }
    }

    private void approveLoan(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int loanId = Integer.parseInt(request.getParameter("loanId"));
        boolean success = loanDAO.updateLoanStatus(loanId, "Approved");

        if (success) {
            request.getSession().setAttribute("message", "Loan approved successfully!");
        } else {
            request.getSession().setAttribute("message", "Failed to approve loan.");
        }

        response.sendRedirect("pendingLoans.jsp");
    }

    private void denyLoan(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int loanId = Integer.parseInt(request.getParameter("loanId"));
        boolean success = loanDAO.updateLoanStatus(loanId, "Denied");

        if (success) {
            request.getSession().setAttribute("message", "Loan denied successfully!");
        } else {
            request.getSession().setAttribute("message", "Failed to deny loan.");
        }

        response.sendRedirect("pendingLoans.jsp");
    }
}