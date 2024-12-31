package com.varshini;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AddCategory extends HttpServlet {

    public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        String categoryName = req.getParameter("category-name");
        
        if (categoryName == null || categoryName.trim().isEmpty()) {
            req.setAttribute("error", "Invalid category name.");
            RequestDispatcher rd = req.getRequestDispatcher("addCategory.jsp"); // Redirect to same JSP
            rd.forward(req, res);
            return; // Exit after forwarding
        }
        
        Connection conn = null;
        try {
            conn = DbConnection.getConnected(); // Using connection from your helper class
            
            // Check if category already exists
            String checkQuery = "SELECT cname FROM category WHERE cname = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setString(1, categoryName);
            ResultSet rs = checkStmt.executeQuery();
            
            if (rs.next()) {
                req.setAttribute("error", "Category already exists.");
                RequestDispatcher rd = req.getRequestDispatcher("addCategory.jsp");
                rd.forward(req, res);
                return;
            }
            
            // Insert the new category
            String insertQuery = "INSERT INTO category (cname) VALUES (?)";
            PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
            insertStmt.setString(1, categoryName);
            insertStmt.executeUpdate();
            
            // Success message
            req.setAttribute("success", "Category added successfully!");
            RequestDispatcher rd = req.getRequestDispatcher("addCategory.jsp");
            rd.forward(req, res); // Forward to the same page to show the success message
            
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Database error: " + e.getMessage());
            RequestDispatcher rd = req.getRequestDispatcher("addCategory.jsp");
            rd.forward(req, res);
        } finally {
            try {
                if (conn != null) conn.close(); // Ensure the connection is closed
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
