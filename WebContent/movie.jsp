<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@page import="javax.sql.DataSource" %>
<%@page import="javax.naming.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="mainpage.css" rel="stylesheet" />
<link href='https://fonts.googleapis.com/css?family=Quattrocento'
	rel='stylesheet' type='text/css'>
<title>The movie mafia</title>
</head>
<body id="moviex">

<%
//session vars
boolean isLoggedIn=false;
String loggedInUser="";
if(session == null){}
else if(session != null){
	isLoggedIn = true;
	loggedInUser = (String)session.getAttribute("LoggedInUser");

	if(loggedInUser==null){
		isLoggedIn=false;
	}




}%>
	  <div style="float:right;width:300px;position:relative;z-index=1;bottom:90px">  
  <ul id="alphabet">
<%if(isLoggedIn){ %>
      <li><a href="#">hello, <%=loggedInUser %></a></li>
      <% }else{%>
		<li><a href="/PikflixWeb">sign in</a></li>
		<li><a href="#">sign up</a></li>
		<%} %>
      <li><a href="/PikflixWeb/cart.jsp">cart</a></li>
      <li><a href="/PikflixWeb/mainpage">home</a></li>
      
      
                        
    </ul>  
    
    </div>    


	<center>
		<div style="width: 700px; height: 150px">
			<center>
				<h1 class="header">The Movie Mafia</h1>
			</center>
		</div>
	</center>

	<center>
		<form method="get" id="search" action="/PikflixWeb/showmovies.jsp">
			<input type="text" class="searchshowmovies" name="search"
				placeholder="Search for movies..." required> <input
				type="submit" value="Search" class="button">
		</form>
	
		<h1 style=" color: white;font-family:Quattrocento;">Movie Details:</h1>
		</center>
	<div id="body">

		<hr class="sep">

		<%


//query processing starts here...
String movieid = request.getParameter("movieid");
String query = "select * from movies where id = "+movieid;

//end query procesing ....

String loginUser = "root";
String loginPasswd = "pikflix";
String loginUrl = "jdbc:mysql://localhost:3306/moviedb";
try{
//	DriverManager.registerDriver(new com.mysql.jdbc.Driver());
//	Class.forName("com.mysql.jdbc.Driver").newInstance();
//	Connection connection = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
	

Context initCtx = new InitialContext();
            if (initCtx == null) out.println ("initCtx is NULL");
		   
	       Context envCtx = (Context) initCtx.lookup("java:comp/env");
           if (envCtx == null) out.println ("envCtx is NULL");
			
	       // Look up our data source
	       DataSource ds = (DataSource) envCtx.lookup("jdbc/TestDB");
	       Connection connection = ds.getConnection();
	
	
	Statement statement = connection.createStatement();
	Statement statementstars = connection.createStatement();
	Statement statementgenres = connection.createStatement();
	ResultSet rs = statement.executeQuery(query);
	rs.next();
	
	
	
	String subquerystars="select id,first_name,last_name from stars where id = any(select star_id from stars_in_movies where movie_id = "+rs.getString(1)+");";
	String subquerygenres="select * from genres where id = any(select genre_id from genres_in_movies where movie_id ="+rs.getString(1)+");";
	ResultSet rsstars = statementstars.executeQuery(subquerystars);
	ResultSet rsgenres = statementgenres.executeQuery(subquerygenres);
%>

		<div id="movie">
			<div id="banner">
				<img src="<%=rs.getString(5) %>"
					style="width: 167px; height: 224px;" />
			</div>

			<div id="details">
				<h1 >
					<strong><a color="darkgoldenrod" id="movietitlelink" href="#"><%=rs.getString(2) %></a></strong> <a
						href="<%=rs.getString(6) %>"> <img src="images/trailer.png"
						style="width: 30px; height: 30px; vertical-align: middle;" /></a>
				</h1>
				<p>
					<strong>Year:</strong> &#160;
					<%=rs.getString(3) %>
					<br> <strong>Director:</strong> &#160;<%=rs.getString(4) %>
					<br> <strong>Stars:</strong>
					<% 

int count = 0;
while(rsstars.next()){ %>

					&#160;<a href="/PikflixWeb/star.jsp?starid=<%=rsstars.getString(1)%>"><%=rsstars.getString(2)%>&#160;<%=rsstars.getString(3)%></a>&#160;

					<% count++; if(count>5){break;}}%>


					<br>
					<strong>Genres:</strong>

					<% count = 0;
while(rsgenres.next()){ %>

					&#160; <a
						href="/PikflixWeb/showmovies.jsp?genreid=<%=rsgenres.getString(1)%>"><%=rsgenres.getString(2) %></a>&#160;


					<%count++; if(count>5){break;}}%>




					<br> <strong>price:</strong> &#160; $15.99<br>
				<form target="blank" method="get" action="/PikflixWeb/cart.jsp">
					<button class="cart" name="movieid" value="<%=rs.getString(1) %>" type="submit">Add to cart +</button>
				</form><br>
				
				<form method="get" action="https://en.wikipedia.org/wiki/<%=rs.getString(2)%>">
					<button class="cart" type="submit">Read more...</button>
				</form>
				</p>
			</div>
		</div>
		<br>
		<hr class="sep">
<footer>
<center>
			<br>
			<br>
			<p style="margin: 0px auto; font-size: 15px; color: white;">
				Copyright &#169; 2016 by Joel, Arpan and Prachi.<br> All rights
				reserved.
			</p>
		</center>
		</footer>

		<%
		
		
			rs.close();
			statementgenres.close();
			statementstars.close();
			connection.close();
			statement.close();
		} catch (SQLException ex) {
			while (ex != null) {
				System.out.println("SQL Exception:  " + ex.getMessage());
				ex.printStackTrace();
			}
		} catch (java.lang.Exception ex) {
			out.println("<HTML>" + "<HEAD><TITLE>" + "MovieDB: Error" + "</TITLE></HEAD>\n<BODY>"
					+ "<P>SQL error in doGet: " + ex.getMessage() + "</P></BODY></HTML>");
			return;
		}
	%>















		
	</div>
</body>
</html>