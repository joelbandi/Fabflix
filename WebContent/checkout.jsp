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
	
		<h1 style=" color: white;font-family:Quattrocento;">Checkout</h1>
		</center>
	<div id="body">

		<hr class="sep">


		
	<center>	
		<fieldset width="300px">
		<form action="/PikflixWeb/sales.jsp" method="post" target="_blank">
		  Last Name: <input type="TEXT" name="lastname"><br>
			First Name: <input type="TEXT" name="firstname"><br>
			Expiration Date: <input type="TEXT" name="exp"><br>
		  Credit Card Number: <input type="PASSWORD" name="cardnum"><br>
		  <center>
		    <input type="submit" value=Checkout>
		  </center>
		</form>
		</fieldset>
</center>

</div>
</body>
</html>