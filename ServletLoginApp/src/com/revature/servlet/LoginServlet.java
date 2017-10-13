package com.revature.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.*;

public class LoginServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req,HttpServletResponse resp) throws ServletException, IOException{
		HttpSession session = req.getSession();
		PrintWriter pw = resp.getWriter();
		resp.setContentType("text/html");
		String wasIncorrect = (String) session.getAttribute("incorrect");
		if(wasIncorrect != null) {
			pw.println(wasIncorrect);
		}
		req.getRequestDispatcher("Login.html").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req,HttpServletResponse resp) throws ServletException, IOException{
		HttpSession session = req.getSession();
		
		resp.setContentType("text/html");
		PrintWriter pw =resp.getWriter();
		
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		
		if(password.equals("admin123")) {
			pw.println("Welcome, "+ username);
			pw.println("<a href=\"Index.html\">Go Back</a>");
			session.setAttribute("username", username);
			session.setAttribute("problem", null);
		} else {
			//pw.println("Lol no");
			//pw.println("<a href=\"Index.html\">Go Back</a>");
			
			session.setAttribute("problem", "incorrect password");
			resp.sendRedirect("login");
		}
	}
}
