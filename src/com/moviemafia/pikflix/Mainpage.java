package com.moviemafia.pikflix;



import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

@WebServlet("/mainpage")
public class Mainpage extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String loginUser = "root";
		String loginPasswd = "pikflix";
		String loginUrl = "jdbc:mysql://localhost:3306/moviedb";
		response.setContentType("text/html");    
		PrintWriter out = response.getWriter();
		//session vars processing...
		
		
		
		HttpSession session = request.getSession(false);
		boolean isLoggedIn=false;
		String loggedInUser="";
		if(session==null){}
		else if(session!=null){
			isLoggedIn = true;
			loggedInUser = (String)session.getAttribute("loggedInUser");
			if(loggedInUser==null){
				isLoggedIn=false;
			}
			
			
		}
		//session vars processing ends here
		out.println("<html><head>"
				+ "<link href=\"bootstrap.css\" rel=\"stylesheet\" />"
				+ "<script src=\"jquery.js\"></script>"
				+ "<link href=\"mainpage.css\" rel=\"stylesheet\" /><link href='https://fonts.googleapis.com/css?family=Quattrocento'rel='stylesheet' type='text/css'><meta http-equiv=\"Content-Type\""
				+ "content=\"text/html; charset=UTF-8\"><title>Movie Mafia</title>"
				+ "<link href=\"tooltipster.css\" rel=\"stylesheet\" />"
				+ "<script src=\"jquery.tooltipster.min.js\"></script>"
				+ "<script>"
				+ "$(document).ready(function() {"
				+ "$('.tooltip').tooltipster({"
				+ "theme: 'tooltipster-default',"
				+ "contentAsHTML: true"
				+ "});"
				+ "});"
				+ "</script>"
				+"<script src=\"typeaheader.js\"></script>"
				+ ""
				+ ""
				+ "<script>"
				+ "$(function(){"
				+ "$(\".searchshowmovies\").typeahead({"
				+ "hint: true,"
				+ "highlight: true"
				+ "},"
				+ "{"
				+ "source: function(query, process){"
				+ "$.ajax({"
				+ "url: 'typeahead',"
				+ "type: 'POST',"
				+ "data: 'typeahead=' + query,"
				+ "dataType: 'JSON',"
				+ "async: false,"
				+ "success: function(data){"
				+ "process(data);"
				+ "}});"
				+ "}});"
				+ "});"
				+ ""
				+ ""
				+ "</script>"
				+ ""
				+ "</head><body "
				+ "id=\"mainpage\">"
				+ "  <div style=\"float:right;width:300px;position:relative;z-index=1;bottom:90px;\">"  
						+"<ul id=\"alphabet\">");
							if(isLoggedIn){
							out.print("<li><a href=\"#\">hello, "+loggedInUser+"</a></li>");
							}else{
							out.print("<li><a href=\"/PikflixWeb\">sign in</a></li>");
							out.print("<li><a href=\"#\">sign up</a></li>");
							}
							out.println("<li><a href=\"/PikflixWeb/cart.jsp\">cart</a></li>"
							+ "<li><a href=\"/PikflixWeb/mainpage\">home</a></li>"
							+ "</ul>"
							+ "</div>"
							
				+ "<center><div style=\"width:700px; height:150px \"><center><h1 "
				+ "class=\"header\">The Movie Mafia</h1></center></div></center><center><form method=\"get\" id=\"search\" "
				+ "action=\"/PikflixWeb/showmovies.jsp\"><input type=\"text\" class=\"searchshowmovies\" "
				+ "name=\"search\" style=\"height:50px;\" data-provide=\"type-ahead\" placeholder=\"Search for movies...\" required><input type=\"submit\" value=\"Search\" "
				+ "class=\"button\"></form><h1 style=\"color:white;font-family:Quattrocento\">Here are some of our favorites:</h1></center><div id=\"body\"><hr class=\"sep\">");
		


		try
		{
			//Class.forName("org.gjt.mm.mysql.Driver");
//			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
//			Class.forName("com.mysql.jdbc.Driver").newInstance();
//			Connection connection = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
			
			
			
			Context initCtx = new InitialContext();
            if (initCtx == null) out.println ("initCtx is NULL");
		   
	       Context envCtx = (Context) initCtx.lookup("java:comp/env");
           if (envCtx == null) out.println ("envCtx is NULL");
			
	       // Look up our data source
	       DataSource ds = (DataSource) envCtx.lookup("jdbc/TestDB");
	       Connection connection = ds.getConnection();
			
			
			
			
			
			
			Statement statement = connection.createStatement();
			
			
			
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////			
			
			
			
			Statement statementstars = connection.createStatement();
			Statement statementgenres = connection.createStatement();
			String query="SELECT * FROM movies ORDER BY RAND() LIMIT 5";
			String subquerystars;
			String subquerygenres;
			ResultSet rs = statement.executeQuery(query);

			
			
			
		//MOVIE ELEMENT ATOMIC CODE BEGINS HERE 	including iter... take params from up there ^^^^
			
			
			while(rs.next()){
				subquerystars="select id,first_name,last_name from stars where id = any(select star_id from stars_in_movies where movie_id = "+rs.getString(1)+");";
				subquerygenres="select * from genres where id = any(select genre_id from genres_in_movies where movie_id ="+rs.getString(1)+");";
				ResultSet rsstars = statementstars.executeQuery(subquerystars);
				ResultSet rsgenres = statementgenres.executeQuery(subquerygenres);
			
				
				out.println("<div id=\"movie\">"
						+ "<div id=\"banner\">"
						+ "<img src=\""+rs.getString(5)+"\" style=\"width:167px;height:233px;\"/></div>"
								+ "<div id=\"details\">"
								+ "<h1><strong><a id=\"movietitlelink\" "
								+ "class = \"tooltip\" title=\"&lt;ins&gt;Title:"+rs.getString(2)+"("+rs.getString(3)+")&lt;/ins&gt; &lt;br&gt;&lt;br&gt;  Director: "+rs.getString(4)+" &lt;br&gt; TrailerURL: "+rs.getString(6)+" &lt;br&gt; BannerURL: "+rs.getString(5)+"\" "
								+ "href=\"/PikflixWeb/movie.jsp?movieid="+rs.getString(1)+"\">"+rs.getString(2)+"</a></strong>"
										+"<a href=\""+rs.getString(6)+"\"><img src=\"images/trailer.png\" style=\"width:30px;height:30px;vertical-align:middle;\"/>"
												+ "</a>"
										+ "</h1>"
										+ "<p><strong>Year:</strong>&#160;"+rs.getString(3)+"<br>"
												+ "<strong>Director:</strong>&#160;"+rs.getString(4)+"<br>"
														+ "<strong>Stars:</strong>&#160;");
				int count=0;
				while(rsstars.next()){										
				out.print("<a href=\"/PikflixWeb/star.jsp?starid="+rsstars.getString(1)+"\">"+rsstars.getString(2)+"&#160;"+rsstars.getString(3)+"</a>&#160;");
				count++;
				if(count>5){break;}
				}rsstars.close();
				
				
				out.println("<br><strong>Genres:</strong>&#160;");
		
				count=0;		
				while(rsgenres.next()){
					out.println("<a href=\"/PikflixWeb/showmovies.jsp?by=genre&genreid="+rsgenres.getString(1)+"&orderby=Yasc&rpp=5&page=1\">"+rsgenres.getString(2)+"&#160;"+"</a>&#160;");
					count++;
					if(count>5){break;}
				}rsgenres.close();
						
						
														out.println("<br><strong>price:</strong>&#160;$15.99<br>"
														+"<form target=\"blank\" method=\"get\" action=\"/PikflixWeb/cart.jsp\">"
												        +"<button class=\"cart\" name=\"movieid\" value=\""+rs.getString(1)+"\" type=\"submit\" >Add to cart +</button>"
												        +"</form>"
														+ "</p>"
														+ "</div>"
														+ "</div><br>"
														+ "<hr class=\"sep\">");
			}
			
			//MOVIE ELEMENT ATOMIC CODE ENDS HERE 	including iter...
			out.println("</div>");
			
			
			
			//implement the browse by genre and browse by title section
			
			out.println("<div>"
					+ "<ul id=\"alphabet\">"
					+ "<h3 style=\"color:white\">Browse by title or Genre: </h3> "
					+ "<hr class=\"sep\">");
			

			for(int i =0;i<=9;i++){
					out.println("<li><a href=\"/PikflixWeb/showmovies.jsp?by=title&amp;title="+i+"&amp;orderby=Yasc&amp;rpp=5&amp;page=1\">"+i+"</a></li>");
			}
			
			for(char c = 'A';c<='Z';c++){
					out.println("<li><a href=\"/PikflixWeb/showmovies.jsp?by=title&amp;title="+c+"&amp;orderby=Yasc&amp;rpp=5&amp;page=1\">"+c+"</a></li>");
			}
			
			out.println("</ul></div>");
			
			//////////////////////////////////////////////////////////////////////////////////////////
			//browse by genre now
			rs=statement.executeQuery("select * from genres;");
			
			out.println("<div>"
					+ "<ul id=\"alphabet\">");
//					+ "<h3 style=\"color:white\">Browse by genres: </h3> "
//					+ "<hr class=\"sep\">");

			while(rs.next()){
				out.println("<li>"
						+ "<a href=\"/PikflixWeb/showmovies.jsp?by=genre&amp;genreid="+rs.getString(1)+"&amp;orderby=Yasc&rpp=5&amp;page=1\">"+rs.getString(2)+"</a>"
								+ "</li>");

			}
			out.println("</ul></div><br><br>");
			
			

			
			
			///ending...
			
			out.println("<center><br><br><p style=\"margin:0px auto;font-size:15px;color:white;\">Copyright &#169; 2016 by Joel, Arpan and Prachi.<br> All rights reserved.</p></center>");
			out.println("</body></html>");
			rs.close();
			statementgenres.close();
			statementstars.close();
			connection.close();
			statement.close();
			out.close();
	
			
		}

		catch (SQLException ex) {
			while (ex != null) {
				System.out.println ("SQL Exception:  " + ex.getMessage ());
				ex = ex.getNextException ();
			} 
		}  

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
		
	
	
	
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
