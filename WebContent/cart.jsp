<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
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






boolean isLoggedIn=false;
String loggedInUser="";
if(session == null){}
else if(session != null){
	isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
	loggedInUser = (String)session.getAttribute("LoggedInUser");
}


String movieid = request.getParameter("movieid");
String action = request.getParameter("action");

String quantity=request.getParameter("quantity");
	ShoppingCart shoppingcart = (ShoppingCart)session.getAttribute("shoppingcart");
	if(shoppingcart == null){
		session.setAttribute("shoppingcart", new ShoppingCart());
		shoppingcart = (ShoppingCart)session.getAttribute("shoppingcart");
		HashMap<Integer,Integer> cart = shoppingcart.getCartItems();
	}else{
		HashMap<Integer,Integer> cart = shoppingcart.getCartItems();
	}
	
	
	










%>
	  <div style="float:right;width:300px;position:relative;z-index=1;bottom:90px">  
  <ul id="alphabet">
<%if(isLoggedIn){ %>
      <li><a href="#">hello,  <%=loggedInUser %></a></li>
      <% }else{%>
		<li><a href="/PikflixWeb">sign in</a></li>
		<li><a href="#">sign up</a></li>
		<%} %>
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
	</center>
	<h1 style="margin-left: 450px; color: white;font-family:Quattrocento;">Your Shopping cart:</h1>
	<div id="body">
		
		<hr class="sep">
		


<%
//query processing starts here...
String query = "select * from movies where id = "+movieid;
String querymovie = "";
//query processing ends here...
String loginUser = "joelbandi";
String loginPasswd = "Al05mighty";
String loginUrl = "jdbc:mysql://localhost:3306/moviedb";
try{
	DriverManager.registerDriver(new com.mysql.jdbc.Driver());
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection connection = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
	Statement statement = connection.createStatement();
	Statement statementmovie = connection.createStatement();
	ResultSet rs = statement.executeQuery(query);
	rs.next();
	//action processing...
	
	
	if(action==null && quantity==null){
		shoppingcart.add(Integer.parseInt(movieid),1);		
	}
	//action processing end...








%>


		<table>

			<thead>
				<tr>
					<th>Movie title</th>
					<th>Quantity</th>
					<th>Price</th>
					<th>Action</th>
					<th>Total</th>

				</tr>
			</thead>
			<tbody>


				<tr>
					<td><%=rs.getString(2) %></td>
					<td>
						<form>
							<input type="number" id="qty" name="qty" value="1" min="1">
						</form>
					</td>
					<td>$16</td>
					<td>

						<form method="get" action="/PikflixWeb/cart.jsp">
							<button name="action" value="update" class="cart" type="submit">update</button>
							<input type="hidden" name="quantity" value="1">
						</form>
						<form method="get" action="PikflixWeb/cart.jsp">
							<button name="action" value="remove" id="cartx" type="submit">remove</button>
						</form>

					</td>
					<td id="value">$16</td>

				</tr>



			</tbody>



			<tfoot>
				<tr>
					<th colspan="4">Grand Total</th>
					<th id="gt"></th>
				</tr>
			</tfoot>
		</table>





<%

rs.close();
statement.close();
statementmovie.close();
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
	
	
}%>













	</div>
</body>
</html>
