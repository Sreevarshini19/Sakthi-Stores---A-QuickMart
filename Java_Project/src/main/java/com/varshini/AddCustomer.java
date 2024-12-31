package com.varshini;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AddCustomer extends HttpServlet {

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        String phoneNum = req.getParameter("phoneNum").trim();

        // Validate phone number
        if (phoneNum == null || phoneNum.isEmpty() || phoneNum.length() != 10 || !phoneNum.matches("\\d+")) {
            req.setAttribute("error", "Invalid Phone Number");
            RequestDispatcher rd = req.getRequestDispatcher("Error.jsp"); // Redirect to Error.jsp
            rd.forward(req, res);
            return; // Exit after forwarding
        }

        String query = "INSERT INTO customer (phone_number) VALUES (?)";
        try (Connection conn = DbConnection.getConnected(); 
        	PreparedStatement pst = conn.prepareStatement(query)) {
            pst.setString(1, phoneNum); 
            int rowsAffected = pst.executeUpdate();
            if (rowsAffected > 0) {
                HttpSession session = req.getSession();
                session.setAttribute("mobile_num", phoneNum); // Store the phone number in session
               // RequestDispatcher rd = req.getRequestDispatcher("viewProductsCust.jsp");
               // rd.forward(req, res); // Redirect to viewProductsCust.jsp
                res.sendRedirect("viewProductsCust.jsp");
            } else {
                throw new SQLException("Failed to insert customer into the database.");
            }
        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
            req.setAttribute("error", "Database error: " + e.getMessage());
            RequestDispatcher rd = req.getRequestDispatcher("Error.jsp");
            rd.forward(req, res);
        }
    }
}
