package com.varshini;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SqServlet extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
		int k=(int)req.getAttribute("k");
		k=k*k;
        PrintWriter out=res.getWriter();
        int i = Integer.parseInt(req.getParameter("num1"));
        int j = Integer.parseInt(req.getParameter("num2"));
//        int i=1,j=10;
        out.println("Hello from SqServlet,the result of "+ i +"and"+j+" is "+k);
    }
}
