package com.varshini;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

public class checkAdmin extends HttpServlet {

	// Database connection method
   

    // POST method to handle form data
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException,ServletException {
        String username = req.getParameter("adminName").trim();
        String password = req.getParameter("adminPassword").trim();

        // Query to filter by username and password
        String query = "SELECT COUNT(*) AS user_count FROM workers WHERE username = ? AND password = ?";
 String query1="insert into  admin_activity_log(username, activity_type, activity_time) values(?,?,?)";
        res.setContentType("text/html");
        PrintWriter out = res.getWriter();

        try (Connection conn = DbConnection.getConnected();
             PreparedStatement pst = conn.prepareStatement(query)) {
        	PreparedStatement pst1=null;
            if (conn == null) {
                out.println("<h3>Database connection failed</h3>");
                return;
            }

            System.out.println("Connection Established");

            // Use placeholders for parameters to avoid SQL injection
            pst.setString(1, username);
            pst.setString(2, password);
            Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next() && rs.getInt("user_count") > 0) {
                   /* RequestDispatcher rd=req.getRequestDispatcher("viewProducts.jsp");
                    rd.forward(req,res);   */
                	
                    pst1=conn.prepareStatement(query1);
                    pst1.setString(1,username);
                    pst1.setString(2, "LOGIN");
                   pst1.setTimestamp(3,currentTimestamp );
                   pst1.executeUpdate();
                	res.sendRedirect("viewProducts.jsp");
                	
                } else {
                    out.println("<h3>Invalid credentials</h3>");
                }
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
            req.setAttribute("error", e.getMessage());
            RequestDispatcher rd=req.getRequestDispatcher("Error.jsp");
            rd.forward(req,res);
        }
    }
}
