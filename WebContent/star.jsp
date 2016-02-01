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

<%
//session vars



boolean isLoggedIn=false;
String loggedInUser="";
if(session == null){}
else if(session != null){
	isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
	loggedInUser = (String)session.getAttribute("LoggedInUser");



}%>
	  <div style="float:right;width:300px;position:relative;z-index=1;bottom:90px">  
  <ul id="alphabet">
<%if(isLoggedIn){ %>
      <li><a href="#">hello,  <%=loggedInUser %></a></li>
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
	
		<h1 style="color: white;font-family:Quattrocento;">Star Details:</h1>
		</center>
	<div id="body">

		<hr class="sep">
		
		<%


//query processing starts here...
String starid = request.getParameter("starid");
String query = "select * from stars where id = "+starid;
//query processing ends here...
String loginUser = "joelbandi";
String loginPasswd = "Al05mighty";
String loginUrl = "jdbc:mysql://localhost:3306/moviedb";
try{
	DriverManager.registerDriver(new com.mysql.jdbc.Driver());
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection connection = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
	Statement statement = connection.createStatement();
	Statement statementmovies = connection.createStatement();
	ResultSet rs = statement.executeQuery(query);
	rs.next();
	String subquerymovies = "select * from movies where id = "
			+"any(select movie_id from stars_in_movies where star_id = "+rs.getString(1)+");";
	ResultSet rsmovies = statementmovies.executeQuery(subquerymovies);
	
	%>
	
		<div id="movie">
    
    
    
    <div id="banner">
    <img src="<%=rs.getString(5) %>" style="width:167px;height:233px;"/>
    </div>

    
    
    
    
    <div style="padding-bottom: 100px;" "id="details">
        <h1 id="movietitle"><strong><%=rs.getString(2)%> <%=rs.getString(3)%></strong>

        </h1>
        <p><strong>Date of Birth:</strong>  &#160; <%=rs.getString(4) %>  <br>
           <strong>Starred in:</strong> &#160;  
     <%
     while(rsmovies.next()){
    	 
     %>       
            
             <a href="/PikflixWeb/movie.jsp?movieid=<%=rsmovies.getString(1)%>">
            <%=rsmovies.getString(2)%>(<%=rsmovies.getString(3)%>)
            </a>&#160;
       
      <%
      	} 
      %> 
                    
            <form method="get" action="https://en.wikipedia.org/wiki/<%=rs.getString(2)%>_<%=rs.getString(3)%>">
        <button class="cart" type="submit" >Read More.. </button>
        </form>
 
    </p>
    </div>
    

    
    
    
    
</div> 
    <br>
<hr class="sep">
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
<%

rs.close();
rsmovies.close();
statement.close();
statementmovies.close();
connection.close();
}catch (SQLException ex) {
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
	</body>
	</html>