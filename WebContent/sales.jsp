<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@page import="javax.sql.DataSource" %>
<%@page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.moviemafia.pikflix.ShoppingCart" %>
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

boolean found = false;
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
	
		<h1 style=" color: white;font-family:Quattrocento;">Sales confirmation:</h1>
		</center>
	<div id="body">

		<hr class="sep">

		<%


//query processing starts here...
String lastname = request.getParameter("lastname");
String firstname = request.getParameter("firstname");
String cardnum = request.getParameter("cardnum");
String exp = request.getParameter("exp");
String query = "SELECT * from creditcards where first_name = '" +firstname + "' and last_name = '" + lastname + "' and id = '" + cardnum + "' and expiration_date = '"+exp+"'";


//fetch cart...
HashMap<Integer,Integer> cart;


ShoppingCart shoppingcart = (ShoppingCart)session.getAttribute("shoppingcart");
if(shoppingcart == null){
	session.setAttribute("shoppingcart", new ShoppingCart());
	shoppingcart = (ShoppingCart)session.getAttribute("shoppingcart");
	cart = shoppingcart.getCartItems();
}else{
	cart = shoppingcart.getCartItems();
}













                














//end query procesing ....

String loginUser = "joelbandi";
String loginPasswd = "Al05mighty";
String loginUrl = "jdbc:mysql://localhost:3306/moviedb";
try{
//	DriverManager.registerDriver(new com.mysql.jdbc.Driver());
//	Class.forName("com.mysql.jdbc.Driver").newInstance();
//	Connection connection = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
	
//get date//
String date = new java.util.Date().toString();

Context initCtx = new InitialContext();
            if (initCtx == null) out.println ("initCtx is NULL");
		   
	       Context envCtx = (Context) initCtx.lookup("java:comp/env");
           if (envCtx == null) out.println ("envCtx is NULL");
			
	       // Look up our data source
	       DataSource ds = (DataSource) envCtx.lookup("jdbc/TestDB");
	       Connection connection = ds.getConnection();
		   Statement statement = connection.createStatement();
		   ResultSet rs = statement.executeQuery(query);
		   if(rs.next()){
			   found=true;
		   }
		   else{
			   %>
			   <center>
			   <h4><a style="text-decorations=none" href="/PikflixWeb/checkout.jsp">Records do not exist <br> Try again </a></h4>
			   </center>
			   <%}
 			int k =0;
		   if(found){
			   for(int key : cart.keySet()){
					for(int i = 1; i<cart.get(key);i++){
					String insertquery = "INSERT INTO sales(customer_id,movie_id,sale_date) values ((SELECT id FROM customers where first_name='"+firstname+"'and last_name='"+lastname+"'),("+key+"),("+date+"))";
					k++;
					}
					
					
					%>
					  <center>
					  <h4 style="color=darkgoldenrod;">Your order of <%=k %> items has been successfully placed</h4><br>
					  
					  <a href="/PikflixWeb/mainpage">Continue shopping!</a>
					  
					  </center>
					  

					  
					  <%
	
					
			   }
			   
			   
		   }
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
		
		
		
		
		
