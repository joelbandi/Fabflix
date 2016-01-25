package com.moviemafia.pikflix;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(description = "pikflix servlet", urlPatterns = { "/login" })
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;



	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException
	{
		String loginUser = "joelbandi";
		String loginPasswd = "Al05mighty";
		String loginUrl = "jdbc:mysql://localhost:3306/moviedb";
		response.setContentType("text/html");    
		PrintWriter out = response.getWriter();

		out.println("<html><head><link href=\"mainpage.css\" rel=\"stylesheet\" /><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"><title>Movie Mafia</title></head><body id=\"mainpage\"><center><div style=\"width:700px; height:150px \"><center><h1 class=\"header\">The Movie Mafia</h1></center></div></center>");

		//

		try
		{
			//Class.forName("org.gjt.mm.mysql.Driver");
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
			Class.forName("com.mysql.jdbc.Driver").newInstance();

			Connection connection = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
			// Declare our statement
			Statement statement = connection.createStatement();

			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String query = "SELECT * from customers where email = '" + email + "'";
			// Perform the query
			ResultSet rs = statement.executeQuery(query);
			out.println("<center>");
			while(rs.next()){
				String check = rs.getString(7);
				if(check.equals(password)){
					response.sendRedirect("/PikflixWeb/mainpage");
					out.println("</BODY></HTML>");
					out.close();
					return;
				}
				else{
					out.println("<br> Wrong password or Username <br> <a href=\"\\PikflixWeb\">Try again</a>");
					out.println("</BODY></HTML>");
					out.close();
					return;
				}
			}
			out.println("<br> Email is not registered <br> <a href=\"\\PikflixWeb\">Try again</a>");
			out.println("</center>");
	
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

