<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h1>holla back!</h1>



<form method="get" ACTION="/PikflixWeb/employeeAction">
<input type="hidden" name="what" value="add_movie"><br><br>
<input name="title" placeholder="Title"><br><br>
<input type="number" name="year" placeholder="year" ><br><br>
<input name="director" placeholder="director"><br><br>
<input name="burl" placeholder="ban url"><br><br>
<input name="turl" placeholder="turn url"><br><br>
<input name="genre" placeholder="genre"><br><br>
<input name="fname" placeholder="firstname"><br><br>
<input name="lname" placeholder="lastname"><br><br>
<input name="dob" placeholder="dob"><br><br>
<input name="purl" placeholder="photo url"><br><br>

<input type="submit" value="sumbit">

</form>

<br>
<br>
<br>
<br>
<form action="/PikflixWeb/employeeAction">
<button type="submit" name="what" value="get_metadata">get metadata</button>
</form>

<form method="get" action="/PikflixWeb/employeeAction">

<input type="hidden" name="what" value="add_star"><br><br>
<input name="fname" placeholder="firstname"><br><br>	
<input name="lname" placeholder="lastname"><br><br>
<input name="starid" placeholder="id"><br><br>
<input name="dob" placeholder="dob"><br><br>
<input name="purl" placeholder="photo url"><br><br>
<input type="submit" value="add this fool">
</form>


















</body>
</html>