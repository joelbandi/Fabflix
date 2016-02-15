package com.moviemafia.pikflix;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

@WebServlet(description = "pikflix servlet", urlPatterns = { "/employeeLogin" })



public class employeeLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException
	{
		String loginUser = "root";
		String loginPasswd = "pikflix";
		String loginUrl = "jdbc:mysql://localhost:3306/moviedb";
		response.setContentType("text/html");    
		PrintWriter out = response.getWriter();

		out.println("<html><head><link href=\"mainpage.css\" rel=\"stylesheet\" /><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"><title>Movie Mafia</title></head><body id=\"mainpage\"><center><div style=\"width:700px; height:150px \"><center><h1 class=\"header\">The Movie Mafia</h1></center></div></center>");

		//
		
		try
		{
//			//Class.forName("org.gjt.mm.mysql.Driver");
//			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
//			Class.forName("com.mysql.jdbc.Driver").newInstance();
//
//			Connection connection = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
			
			Context initCtx = new InitialContext();
            if (initCtx == null) out.println ("initCtx is NULL");
		   
	       Context envCtx = (Context) initCtx.lookup("java:comp/env");
           if (envCtx == null) out.println ("envCtx is NULL");
			
	       // Look up our data source
	       DataSource ds = (DataSource) envCtx.lookup("jdbc/TestDB");
	       Connection connection = ds.getConnection();
			
			// Declare our statement
			Statement statement = connection.createStatement();
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String query = "SELECT * from employees where email = '" + email + "'";
			// Perform the query
			ResultSet rs = statement.executeQuery(query);
			out.println("<center>");
			while(rs.next()){
				String check = rs.getString(2);
				if(check.equals(password)){
					//begin setting session vars for user auth and cart init...
					
					
					
					HttpSession session = request.getSession(true);
					session.setAttribute("isLoggedIn", true);
					session.setAttribute("loggedInEUser", rs.getString(1));
					
					
					
					
					
					//end setting session vars for user auth and cart init...
					response.sendRedirect("/PikflixWeb/employee.jsp");
					out.println("</BODY></HTML>");
					out.close();
					return;
				}
				else{
					out.println("<br><span style=\"font-size:50px;color:darkgoldenrod;font-family:godfather\"> <br> <a href=\"\\PikflixWeb\">Try again</a>");
					out.println("</BODY></HTML>");
					out.close();
					return;
				}
			}
			out.println("<br><span style=\"font-size:50px;color:darkgoldenrod;font-family:godfather\">Email is not registered!</span><br> <a href=\"\\PikflixWeb\">Try again</a>");
			out.println("</center>");
			
			rs.close();
			statement.close();
			connection.close();
			
	
		}

		catch (SQLException ex) {
			while (ex != null) {
				System.out.println ("SQL Exception:  " + ex.getMessage ());
				ex = ex.getNextException ();
			}  // end while
		}  // end catch SQLException

		catch(java.lang.Exception ex)
		{
			out.println("<HTML>" +
					"<HEAD><TITLE>" +
					"MovieDB: Error" +
					"</TITLE></HEAD>\n<BODY>" +
					"<P>SQL error in doGet: " +
					ex.getMessage() + "</P></BODY></HTML>");
			return;
		}
		out.println("</body></html>");
		out.close();
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException{
		doGet(request,response);
	}

}

