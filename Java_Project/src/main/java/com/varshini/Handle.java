package com.varshini;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
public class Handle extends HttpServlet {
//	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException,IOException{
		
		res.setContentType("text/html");
		PrintWriter out=res.getWriter();
		
		String name=req.getParameter("name");
		String id_str=req.getParameter("id");
		try {
			if(id_str==null || id_str.trim().isEmpty()) {
				throw new NumberFormatException("Id is null");
			}
			int id=Integer.parseInt(id_str);
			out.println("<html><body>");
			out.println("<h1>Hello "+name +"ID: "+id+"<h1>");
			out.println("<body><html>");
		}
		catch(NumberFormatException e) {
			System.out.println(e.getMessage());
		}
		finally {
			out.close();
		}
	}
}
