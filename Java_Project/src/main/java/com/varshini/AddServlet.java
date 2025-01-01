package com.varshini;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class AddServlet extends HttpServlet {
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException{
		String name=req.getParameter("name");
		Integer age=Integer.parseInt(req.getParameter("age"));
		String message;
		if(age>=18) {
			message="Eligible to vote";
			RequestDispatcher rd=req.getRequestDispatcher("success");
			rd.forward(req, res);
		}
		else {
			message="not Eligible to vote";
			RequestDispatcher rd=req.getRequestDispatcher("NewFile.jsp");
			rd.include(req,res);
		}
	}
}
