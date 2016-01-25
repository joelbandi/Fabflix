package com.moviemafia.pikflix;



import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/mainpage")
public class Mainpage extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String loginUser = "joelbandi";
		String loginPasswd = "Al05mighty";
		String loginUrl = "jdbc:mysql://localhost:3306/moviedb";
		response.setContentType("text/html");    
		PrintWriter out = response.getWriter();
		out.println("<html><head><link href=\"mainpage.css\" rel=\"stylesheet\" /><meta http-equiv=\"Content-Type\" "
				+ "content=\"text/html; charset=UTF-8\"><title>Movie Mafia</title></head><body "
				+ "id=\"mainpage\"><center><div style=\"width:700px; height:150px \"><center><h1 "
				+ "class=\"header\">The Movie Mafia</h1></center></div></center><center><form method=\"get\" id=\"search\" "
				+ "action=\"/PikflixWeb/search\"><input type=\"text\" class=\"search\" "
				+ "name=\"pagequery\" placeholder=\"Search...\" required><input type=\"submit\" value=\"Search\" "
				+ "class=\"button\"></form></center><div id=\"body\"><hr class=\"sep\">");
		


		try
		{
			//Class.forName("org.gjt.mm.mysql.Driver");
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection connection = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
			Statement statement = connection.createStatement();
			String query="select * from movies order by year_ desc limit 0,5;";
			ResultSet rs = statement.executeQuery(query);
			while(rs.next()){
				out.println("<div id=\"movie\">"
						+ "<div id=\"banner\">"
						+ "<img src=\""+rs.getString(5)+"\" style=\"width:167px;height:233px;\"/></div>"
								+ "<div id=\"details\">"
								+ "<h1>"+rs.getString(2)+"</h1>"
										+ "<p>Year:"+rs.getString(3)+"<br>"
												+ "Director:"+rs.getString(4)+"<br>"
														+ "Stars:a,b,c<br>"
														+ "Genres:x,y,z<br>"
														+ "price:$15.99<br>"
														+ "</p>"
														+ "</div>"
														+ "</div>"
														+ "<hr class=\"sep\">");
			}
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
		out.println("</div></body></html>");
		out.close();	
	
	
	
	}
	

	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
