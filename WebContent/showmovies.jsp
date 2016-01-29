<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="mainpage.css" rel="stylesheet" />
<link href='https://fonts.googleapis.com/css?family=Quattrocento'
	rel='stylesheet' type='text/css'>
<title>The movie mafia</title>
</head>
<body id="showmovies">
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
				placeholder="Search for movies..." required> <input type="submit"
				value="Search" class="button">
		</form>
	</center>

	<div id="body">

		<hr class="sep">


		<%
//++++++++++++++++++++++++begin query processing+++++++++++++++++++++++++++++++++++

String orderby = "Yasc";
String orderby_1 = "year_"; 
String orderby_2 = "asc";
String rpp="5";
String pageno="1";
String query="";
String subquerystars;
String subquerygenres;


String by = request.getParameter("by");
System.out.println(by);
if(by==null){
	String search = request.getParameter("search");
	query="select * from movies where title like '%"+search+"%' order by "+orderby_1+" "+orderby_2+" limit "
	+Integer.parseInt(rpp)*(Integer.parseInt(pageno)-1)+","+Integer.parseInt(rpp)*Integer.parseInt(pageno)+";";
}

	else if(by.equals("title")){
	String title = request.getParameter("title");
	query="SELECT distinct id,title,year_,director,banner_url,trailer_url FROM "
			+"(SELECT genres.name,genres_in_movies.movie_id,genres_in_movies.genre_id FROM "
			+"genres INNER JOIN genres_in_movies ON genres.id=genres_in_movies.genre_id) T1 INNER JOIN movies ON "
			+"T1.movie_id=movies.id WHERE LEFT(title,1)='"+title+"'"+"order by "+orderby_1+" "+orderby_2+" limit "
					+Integer.parseInt(rpp)*(Integer.parseInt(pageno)-1)+","+Integer.parseInt(rpp)*Integer.parseInt(pageno)+";";
	
	System.out.println(query);
}

 else if(by.equals("genre")){
 	String genreid = request.getParameter("genreid");
 	query="SELECT distinct id,title,year_,director,banner_url,trailer_url FROM "
 			+"(SELECT genres.name,genres_in_movies.movie_id,genres_in_movies.genre_id FROM "
 			+"genres INNER JOIN genres_in_movies ON genres.id=genres_in_movies.genre_id) T1 INNER JOIN movies ON "
 			+"T1.movie_id=movies.id WHERE genre_id='"+genreid+"'"+"order by "+orderby_1+" "+orderby_2+" limit "
 					+Integer.parseInt(rpp)*(Integer.parseInt(pageno)-1)+","+Integer.parseInt(rpp)*Integer.parseInt(pageno)+";";
	
 	System.out.println(query);
}


//+++++++++++++++++++++++++end query processing++++++++++++++++++++++++++++++++++++
String loginUser = "joelbandi";
String loginPasswd = "Al05mighty";
String loginUrl = "jdbc:mysql://localhost:3306/moviedb";
try{
	DriverManager.registerDriver(new com.mysql.jdbc.Driver());
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection connection = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
	Statement statement = connection.createStatement();
	Statement statementstars = connection.createStatement();
	Statement statementgenres = connection.createStatement();
	ResultSet rs = statement.executeQuery(query);

	while(rs.next()){
		subquerystars="select id,first_name,last_name from stars where id = all(select star_id from stars_in_movies where movie_id = "+rs.getString(1)+");";
		subquerygenres="select * from genres where id = all(select genre_id from genres_in_movies where movie_id ="+rs.getString(1)+");";
		ResultSet rsstars = statementstars.executeQuery(subquerystars);
		ResultSet rsgenres = statementgenres.executeQuery(subquerygenres);
	%>

		<div id="movie">
			<div id="banner">
				<img src="<%=rs.getString(5) %>"
					style="width: 157px; height: 212px;" />
			</div>

			<div id="details">
				<h1 color="darkgoldenrod" id="movietitlelink">
					<strong><a href="#"><%=rs.getString(2) %></a></strong> <a
						href="<%=rs.getString(6) %>"> <img src="images/trailer.png"
						style="width: 30px; height: 30px; vertical-align: middle;" /></a>
				</h1>
				<p>
					<strong>Year:</strong> &#160;
					<%=rs.getString(3) %>
					<br> <strong>Director:</strong> &#160;<%=rs.getString(4) %>
					<br>
					<strong>Stars:</strong> 
					<% 
   
   int count = 0;
   while(rsstars.next()){ %>

					&#160;<a href="/PikflixWeb/star?starid=<%=rsstars.getString(1)%>"><%=rsstars.getString(2)%>&#160;<%=rsstars.getString(3)%>&#160;</a>

					<% count++; if(count>5){break;}}%>


					<br><strong>Genres:</strong> 

<% count = 0;
   while(rsgenres.next()){ %>

					&#160;
					<a href="/PikflixWeb/showmovies.jsp?genreid=<%=rsgenres.getString(1)%>"><%=rsgenres.getString(2) %>&#160;</a>


					<%count++; if(count>5){break;}}%>




					<br>
					<strong>price:</strong> &#160; $15.99<br>
				<form method="get" action="#">
					<button class="cart" type="submit">Add to cart +</button>
				</form>
				</p>
			</div>
		</div>
		<br>
		<hr class="sep">


		<%	
	}
}catch (SQLException ex) {
	while (ex != null) {
		System.out.println ("SQL Exception:  " + ex.getMessage ());
		ex.printStackTrace();
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
		
%>



	</div>
</body>
</html>