<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ page import ="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="mainpage.css" rel="stylesheet" />
<link href='https://fonts.googleapis.com/css?family=Quattrocento' rel='stylesheet' type='text/css'>
<title>The movie mafia</title>
</head>
<body id="showmovies">
    <center>
        <div style="width:700px; height:150px ">
        <center>
            <h1 class="header">
            The Movie Mafia
            </h1>
        </center>
        </div>
    </center>
              
<center>        
 <form method="get" id="search" action="/PikflixWeb/search">
        <input type="text" class="searchshowmovies" name="pagequery" placeholder="Search..." required>
        <input type="submit" value="Search" class="button">
</form>
    </center>   
        
<div id="body">
 
<hr class="sep">


<%
//++++++++++++++++++++++++begin query processing+++++++++++++++++++++++++++++++++++

String query = "";






















//+++++++++++++++++++++++++end query processing++++++++++++++++++++++++++++++++++++

String loginUser = "joelbandi";
String loginPasswd = "Al05mighty";
String loginUrl = "jdbc:mysql://localhost:3306/moviedb";
/* try{
	DriverManager.registerDriver(new com.mysql.jdbc.Driver());
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection connection = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
	Statement statement = connection.createStatement();
	ResultSet rs = statement.executeQuery(query);
	
}catch (SQLException ex) {
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
} */		
%>





</div>
</body>
</html>