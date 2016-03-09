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

<link href="bootstrap.css" rel="stylesheet" />
<script src="jquery.js"></script>

<link href="mainpage.css" rel="stylesheet" />
<link href='https://fonts.googleapis.com/css?family=Quattrocento'
	rel='stylesheet' type='text/css'>
<title>The movie mafia</title>


<!-- typeahead and imports for those things -->

<script src="typeaheader.js"></script>
<script>

$(function(){
	$(".searchshowmovies").typeahead({
		hint: true,
		highlight: true	
	},
	{
		source: function(query, process){
			$.ajax({
				url: 'typeahead',
				type: 'POST',
				data: 'typeahead=' + query,
				dataType: 'JSON',
				async: false,
				success: function(data){
					process(data);
				}
			});
		}
	});
});

</script>


</head>
<body id="showmovies">

<%
//session vars


boolean isLoggedIn=false;
String loggedInUser="";
if(session == null){}
else if(session != null){
	isLoggedIn = true;
	loggedInUser = (String)session.getAttribute("loggedInUser");
	if(loggedInUser==null){
		isLoggedIn=false;
	}
}

//end sessionvars

//request params begin
int gt = 0;
String movieid = request.getParameter("movieid");
String action = request.getParameter("action");
String quantity=request.getParameter("quantity");



//fetching cart..
HashMap<Integer,Integer> cart;
ShoppingCart shoppingcart = (ShoppingCart)session.getAttribute("shoppingcart");
if(shoppingcart == null){
	session.setAttribute("shoppingcart", new ShoppingCart());
	shoppingcart = (ShoppingCart)session.getAttribute("shoppingcart");
	cart = shoppingcart.getCartItems();
}else{
	cart = shoppingcart.getCartItems();
}
	
	










%>
	  <div style="float:right;width:300px;position:relative;z-index=1;bottom:90px">  
  <ul id="alphabet">
<%if(isLoggedIn){ %>
      <li><a href="#">hello,  <%=loggedInUser %></a></li>
      <% }else{%>
		<li><a href="/fabflix">sign in</a></li>
		<li><a href="#">sign up</a></li>
		<%} %>
      <li><a href="/fabflix/mainpage">home</a></li>
      
      
                        
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
		<form method="get" id="search" action="/fabflix/showmovies.jsp">
			<input type="text" class="searchshowmovies" style="height:40px;" data-provide="type-ahead" name="search"
				placeholder="Search for movies..." required> <input
				type="submit" value="Search" class="button">
		</form>
	
	<h1 style=" color: white;font-family:Quattrocento;">Your Shopping cart:</h1>
	</center>
	<div id="body">
		<a href="/fabflix/checkout.jsp?" style="color:darkgoldenrod;text-decoration:none;position:relative;left:700px">Proceed to checkout</a>
		<hr class="sep">
		


<%
			String loginUser = "root";
		String loginPasswd = "pikflix";
		String loginUrl = "jdbc:mysql://localhost:3306/moviedb";
		try{
// 			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
// 			Class.forName("com.mysql.jdbc.Driver").newInstance();
// 			Connection connection = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);



Context initCtx = new InitialContext();
            if (initCtx == null) out.println ("initCtx is NULL");
		   
	       Context envCtx = (Context) initCtx.lookup("java:comp/env");
           if (envCtx == null) out.println ("envCtx is NULL");
			
	       // Look up our data source
	       DataSource ds = (DataSource) envCtx.lookup("jdbc/TestDB");
	       Connection connection = ds.getConnection();
			Statement statement = connection.createStatement();
			
			//action processing...
			
				if (movieid == null) {
				} else {
					if (action == null && quantity == null) {

						shoppingcart.add(Integer.parseInt(movieid), 1);
					}

					else if (action.equals("update")) {
						shoppingcart.update(Integer.parseInt(movieid), Integer.parseInt(quantity));
					}

					else if (action.equals("remove")) {
						shoppingcart.delete(Integer.parseInt(movieid));
					}
				}

				//action processing end...
		%>
	<center>

		<table border="1" >

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


<% 

int k =1;
for(int key : cart.keySet()){
	//query processing starts here...
	String query = "select * from movies where id = "+key;
	//query processing ends here...
	ResultSet rs = statement.executeQuery(query);
	rs.next();
	
	
	
	%>



				<tr>
					<td><%=rs.getString(2) %></td>
					<td>
						<form>
							<input oninput="func<%=k %>()" type="number" id="qty<%=k%>" name="qty" value="<%=cart.get(key)%>" min="1">
							<script type="text/javascript">
							function func<%=k%>(){
								var i = document.getElementById("qty<%=k%>").value;
								document.getElementById("updated<%=k%>").value = i;
							}
							</script>

						</form>
					</td>
					<td>$16</td>
					<td>

						<form method="get" action="/fabflix/cart.jsp">
							<button name="action" value="update" class="cart" type="submit">update</button>
							<input type="hidden" id="updated<%=k %>" name="quantity" value="<%=cart.get(key)%>">
							<input type="hidden" name="movieid" value="<%=key%>">
						</form>
						<br>
						<form method="get" action="/fabflix/cart.jsp">
							<button name="action" value="remove" id="cartx" type="submit">remove</button>
							<input type="hidden" name="movieid" value="<%=key%>">
						</form>

					</td>
					<td id="rt">$<%=16*cart.get(key) %></td>

				</tr>

<%
k++;
gt=gt+(16*cart.get(key));
rs.close();}


%>

			</tbody>



			<tfoot>
				<tr>
					<th colspan="4">Grand Total</th>
					<th id="gt">$<%=gt%></th>
				</tr>
			</tfoot>
		</table>





<%
statement.close();
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












</center>
	</div>
</body>
</html>
