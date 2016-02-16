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
<body id="showmovies">

<%


//session vars...
 		session = request.getSession(false);
 		boolean isLoggedIn=false;
 		String loggedInUser="";
 		if(session==null){}
 		else if(!session.equals(null)){
 			isLoggedIn = true;
 			loggedInUser = (String)session.getAttribute("loggedInUser");
 			if(loggedInUser==null){
				isLoggedIn=false;
			}
 		}



%>


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
				placeholder="Search for movies..." required>
				<input type="submit" value="Search" class="button">
		</form>
	
<h1 style="color: white;font-family:Quattrocento;">Results:</h1>
</center>
	


		<%
//++++++++++++++++++++++++begin query processing+++++++++++++++++++++++++++++++++++

String orderby = "";
String orderby_1="";
String orderby_2="";
orderby=request.getParameter("orderby");
if(orderby==null){
orderby_1 = "year_";
orderby_2="asc";
}

else if(orderby.equals("Yasc")){orderby_1="year_"; orderby_2="asc";}
else if(orderby.equals("Ydes")){orderby_1="year_"; orderby_2="desc";}
else if(orderby.equals("Tasc")){orderby_1="title"; orderby_2="asc";}
else if(orderby.equals("Tdes")){orderby_1="title"; orderby_2="desc";}



String rpp=request.getParameter("rpp");
if(rpp==null){rpp="5";}

String pageno=request.getParameter("page");
if(pageno==null || pageno.equals("0")){pageno="1";}

System.out.println("rpp -> "+rpp);
System.out.println("pageno -> "+pageno);

String query="";
String type="";
String subquerystars;
String subquerygenres;
String search="";
String title="";
String genreid="";

String by = request.getParameter("by");
if(by==null){
	type="search";
	search = request.getParameter("search");
	query="select * from movies where title like '%"+search+"%'" 
			+" order by "+orderby_1+" "+orderby_2+" limit "
 	+Integer.parseInt(rpp)*(Integer.parseInt(pageno)-1)+","+Integer.parseInt(rpp)+";";
 	System.out.println(query);
}

	else if(by!=null && by.equals("title")){
		type="title";
	title = request.getParameter("title");
	query="SELECT distinct id,title,year_,director,banner_url,trailer_url FROM "
			+"(SELECT genres.name,genres_in_movies.movie_id,genres_in_movies.genre_id FROM "
			+"genres INNER JOIN genres_in_movies ON genres.id=genres_in_movies.genre_id) T1 INNER JOIN movies ON "
			+"T1.movie_id=movies.id WHERE LEFT(title,1)='"+title+"'"+"order by "+orderby_1+" "+orderby_2+" limit "
					+Integer.parseInt(rpp)*(Integer.parseInt(pageno)-1)+","+Integer.parseInt(rpp)+";";
					System.out.println(query);
	
}

 else if(by!=null && by.equals("genre")){
	 type="genreid";
 	genreid = request.getParameter("genreid");
 	query="SELECT distinct id,title,year_,director,banner_url,trailer_url FROM "
 			+"(SELECT genres.name,genres_in_movies.movie_id,genres_in_movies.genre_id FROM "
 			+"genres INNER JOIN genres_in_movies ON genres.id=genres_in_movies.genre_id) T1 INNER JOIN movies ON "
 			+"T1.movie_id=movies.id WHERE genre_id='"+genreid+"'"+"order by "+orderby_1+" "+orderby_2+" limit "
 					+Integer.parseInt(rpp)*(Integer.parseInt(pageno)-1)+","+Integer.parseInt(rpp)+";";
	System.out.println(query);
}


//+++++++++++++++++++++++++end query processing++++++++++++++++++++++++++++++++++++
String loginUser = "root";
String loginPasswd = "pikflix";
String loginUrl = "jdbc:mysql://localhost:3306/moviedb";
//session vars begin

		//session = request.getSession(false);
		



//session vars end
%>



<center>
	
	<div>
    
  <ul id="alphabet">
     
     <%if(by==null){%>
      <li><a font-size="25px" href="/PikflixWeb/showmovies.jsp?search=<%=search %>&amp;orderby=Tasc&amp;rpp=<%=rpp %>&amp;page=<%=pageno%>">Ascending-title</a></li>
      <li><a font-size="25px" href="/PikflixWeb/showmovies.jsp?search=<%=search %>&amp;orderby=Tdes&amp;rpp=<%=rpp %>&amp;page=<%=pageno%>">Descending-title</a></li>
      <li><a font-size="25px" href="/PikflixWeb/showmovies.jsp?search=<%=search %>&amp;orderby=Yasc&amp;rpp=<%=rpp %>&amp;page=<%=pageno%>">Ascending-year</a></li>
      <li><a font-size="25px" href="/PikflixWeb/showmovies.jsp?search=<%=search %>&amp;orderby=Ydes&amp;rpp=<%=rpp %>&amp;page=<%=pageno%>">Descending-year</a></li>
	<%} %>
	
	<%if(by!=null && by.equals("genre")){%>
      <li><a font-size="25px" href="/PikflixWeb/showmovies.jsp?by=genre&amp;genreid=<%=genreid %>&amp;orderby=Tasc&amp;rpp=<%=rpp %>&amp;page=<%=pageno%>">Ascending-title</a></li>
      <li><a font-size="25px" href="/PikflixWeb/showmovies.jsp?by=genre&amp;genreid=<%=genreid %>&amp;orderby=Tdes&amp;rpp=<%=rpp %>&amp;page=<%=pageno%>">Descending-title</a></li>
      <li><a font-size="25px" href="/PikflixWeb/showmovies.jsp?by=genre&amp;genreid=<%=genreid %>&amp;orderby=Yasc&amp;rpp=<%=rpp %>&amp;page=<%=pageno%>">Ascending-year</a></li>
      <li><a font-size="25px" href="/PikflixWeb/showmovies.jsp?by=genre&amp;genreid=<%=genreid %>&amp;orderby=Ydes&amp;rpp=<%=rpp %>&amp;page=<%=pageno%>">Descending-year</a></li>
	<%} %>
	
	<%if(by!=null && by.equals("title")){%>
      <li><a font-size="25px" href="/PikflixWeb/showmovies.jsp?by=title&amp;title=<%=title %>&amp;orderby=Tasc&amp;rpp=<%=rpp %>&amp;page=<%=pageno%>">Ascending-title</a></li>
      <li><a font-size="25px" href="/PikflixWeb/showmovies.jsp?by=title&amp;title=<%=title %>&amp;orderby=Tdes&amp;rpp=<%=rpp %>&amp;page=<%=pageno%>">Descending-title</a></li>
      <li><a font-size="25px" href="/PikflixWeb/showmovies.jsp?by=title&amp;title=<%=title %>&amp;orderby=Yasc&amp;rpp=<%=rpp %>&amp;page=<%=pageno%>">Ascending-year</a></li>
      <li><a font-size="25px" href="/PikflixWeb/showmovies.jsp?by=title&amp;title=<%=title %>&amp;orderby=Ydes&amp;rpp=<%=rpp %>&amp;page=<%=pageno%>">Descending-year</a></li>
	<%} %>

                        
    </ul>  
    
</div>
	
	
	
	
	
	</center>
	



	<div id="body">

		<hr class="sep">









<%
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
	
	PreparedStatement statement = connection.prepareStatement(query);
	
	ResultSet rs = statement.executeQuery();

	while(rs.next()){
		System.out.println(rs.getString(2));
		subquerystars="select id,first_name,last_name from stars where id = any(select star_id from stars_in_movies where movie_id = "+rs.getString(1)+");";
		subquerygenres="select * from genres where id = any(select genre_id from genres_in_movies where movie_id ="+rs.getString(1)+");";
		PreparedStatement statementstars = connection.prepareStatement(subquerystars);
		PreparedStatement statementgenres = connection.prepareStatement(subquerygenres);
		ResultSet rsstars = statementstars.executeQuery();
		ResultSet rsgenres = statementgenres.executeQuery();
	%>

		<div id="movie">
			<div id="banner">
				<img src="<%=rs.getString(5) %>"
					style="width: 157px; height: 212px;" />
			</div>

			<div id="details">
				<h1 >
					<strong><a color="darkgoldenrod" id="movietitlelink" href="/PikflixWeb/movie.jsp?movieid=<%=rs.getString(1)%>"><%=rs.getString(2) %></a></strong> <a
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

					&#160;<a href="/PikflixWeb/star.jsp?starid=<%=rsstars.getString(1)%>"><%=rsstars.getString(2)%>&#160;<%=rsstars.getString(3)%></a>&#160;

					<% count++; if(count>5){break;}}%>


					<br><strong>Genres:</strong> 

<% count = 0;
   while(rsgenres.next()){ %>

					&#160;
					<a href="/PikflixWeb/showmovies.jsp?genreid=<%=rsgenres.getString(1)%>"><%=rsgenres.getString(2) %></a>&#160;


					<%count++; if(count>5){break;}}%>




					<br>
					<strong>price:</strong> &#160; $15.99<br>
				<form target="blank" method="get" action="/PikflixWeb/cart.jsp">
					<button class="cart" name="movieid" value="<%=rs.getString(1)%>" type="submit">Add to cart +</button>
				</form>
				</p>
			</div>
		</div>
		<br>
		<hr class="sep">


		<%
			}
	
				%>
		
				<%
				rs.close();
				//statementgenres.close();
				//statementstars.close();
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

<center>
<div>

<%if(by==null) {%>
<a href="/PikflixWeb/showmovies.jsp?search=<%=search %>&amp;orderby=<%=orderby %>&amp;rpp=<%=rpp %>&amp;page=<%=Integer.parseInt(pageno)-1%>" style="text-decoration:none;padding-right:250px" href="#">&lt;&lt;prev</a>
<a href="/PikflixWeb/showmovies.jsp?search=<%=search %>&amp;orderby=<%=orderby %>&amp;rpp=<%=rpp %>&amp;page=<%=Integer.parseInt(pageno)+1%>" style="text-decoration:none;padding-left:250px" href="#">next&gt;&gt;</a>
<%} %>

<%if(by!=null && by.equals("genre")) {%>
<a href="/PikflixWeb/showmovies.jsp?by=genre&amp;genreid=<%=genreid %>&amp;orderby=<%=orderby %>&amp;rpp=<%=rpp %>&amp;page=<%=Integer.parseInt(pageno)-1%>" style="text-decoration:none;padding-right:250px" href="#">&lt;&lt;prev</a>
<a href="/PikflixWeb/showmovies.jsp?by=genre&amp;genreid=<%=genreid %>&amp;orderby=<%=orderby %>&amp;rpp=<%=rpp %>&amp;page=<%=Integer.parseInt(pageno)+1%>" style="text-decoration:none;padding-left:250px" href="#">next&gt;&gt;</a>
<%} %>


<%if(by!=null && by.equals("title")) {%>
<a href="/PikflixWeb/showmovies.jsp?by=title&amp;title=<%=title%>&amp;orderby=<%=orderby %>&amp;rpp=<%=rpp %>&amp;page=<%=Integer.parseInt(pageno)-1%>" style="text-decoration:none;padding-right:250px" href="#">&lt;&lt;prev</a>
<a href="/PikflixWeb/showmovies.jsp?by=title&amp;title=<%=title%>&amp;orderby=<%=orderby %>&amp;rpp=<%=rpp %>&amp;page=<%=Integer.parseInt(pageno)+1%>" style="text-decoration:none;padding-left:250px" href="#">next&gt;&gt;</a>
<%} %>

</div>
</center>
<ul id="alphabet">
     <h3 style="color:white">Results per page</h3> 

<%if(by==null){ %>
      <li><a href="/PikflixWeb/showmovies.jsp?search=<%=search %>&amp;orderby=<%=orderby %>&amp;rpp=5&amp;page=<%=pageno%>">5</a></li>
      <li><a href="/PikflixWeb/showmovies.jsp?search=<%=search %>&amp;orderby=<%=orderby %>&amp;rpp=10&amp;page=<%=pageno%>">10</a></li>
      <li><a href="/PikflixWeb/showmovies.jsp?search=<%=search %>&amp;orderby=<%=orderby %>&amp;rpp=15&amp;page=<%=pageno%>">15</a></li>
      <li><a href="/PikflixWeb/showmovies.jsp?search=<%=search %>&amp;orderby=<%=orderby %>&amp;rpp=20&amp;page=<%=pageno%>">20</a></li>
      <%} %>

<%if(by!=null && by.equals("genre")){ %>
      <li><a href="/PikflixWeb/showmovies.jsp?by=genre&amp;genreid=<%=genreid%>&amp;orderby=<%=orderby %>&amp;rpp=5&amp;page=<%=pageno%>">5</a></li>
      <li><a href="/PikflixWeb/showmovies.jsp?by=genre&amp;genreid=<%=genreid%>&amp;orderby=<%=orderby %>&amp;rpp=10&amp;page=<%=pageno%>">10</a></li>
      <li><a href="/PikflixWeb/showmovies.jsp?by=genre&amp;genreid=<%=genreid%>&amp;orderby=<%=orderby %>&amp;rpp=15&amp;page=<%=pageno%>">15</a></li>
      <li><a href="/PikflixWeb/showmovies.jsp?by=genre&amp;genreid=<%=genreid%>&amp;orderby=<%=orderby %>&amp;rpp=20&amp;page=<%=pageno%>">20</a></li>
      <%} %>

<%if(by!=null && by.equals("title")){ %>
      <li><a href="/PikflixWeb/showmovies.jsp?by=title&amp;title=<%=title%>&amp;orderby=<%=orderby %>&amp;rpp=5&amp;page=<%=pageno%>">5</a></li>
      <li><a href="/PikflixWeb/showmovies.jsp?by=title&amp;title=<%=title%>&amp;orderby=<%=orderby %>&amp;rpp=10&amp;page=<%=pageno%>">10</a></li>
      <li><a href="/PikflixWeb/showmovies.jsp?by=title&amp;title=<%=title%>&amp;orderby=<%=orderby %>&amp;rpp=15&amp;page=<%=pageno%>">15</a></li>
      <li><a href="/PikflixWeb/showmovies.jsp?by=title&amp;title=<%=title%>&amp;orderby=<%=orderby %>&amp;rpp=5&amp;page=<%=pageno%>">20</a></li>
      <%} %>

</ul>

    <center><br><br><p style="margin:0px auto;">---</p><p style="margin:0px auto;font-size:15px;color:white;">Copyright &#169; 2016 by Joel, Arpan and Prachi.<br> All rights reserved.</p></center>

</body>
</html>