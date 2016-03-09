<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="Login.css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Movie Mafia</title>
    <style>
    
        #addmovie{
            
            width:450px;
            background-color:white;
            margin-left: 225px;
            margin-right: 25px;
            margin-bottom:5px;
            float:left;
            
        }
        
        #editmovie{
            
            width:450px;
            background-color:white;
            margin-left: 25px;
            margin-right: 25px;
            margin-bottom:5px;
            float:left;
        }
        
        #addstar{
            
            width:450px;
            background-color:white;
            margin-left: 25px;
            margin-right: 25px;
            margin-bottom:5px;
            float:left;
        }
        
        #metadata{
            
            width:450px;
            background-color:white;
            margin-top:25px;
            margin-left: 25px;
            margin-right: 25px;
            margin-bottom:5px;
            float:left;
        }
        
        input {
 width:255px;
 height:15px;
 padding:5px;
 border-radius:5px;
 font-size:1.2em;
 border: 1px solid grey;
 margin-bottom:0px;
 }
    
        
        label {
 width:150px;
 float:left;
 padding-top:7px;
 }
    
    
    </style>
</head>
<body id="login">
    <center>
        <div style="width:700px; height:150px ">
        <center>
            <h1 class="header">
            The Movie Mafia Dashboard
            </h1>
            <br>
        </center>
        </div>
    </center>
      
    
    
    
<div id="addmovie">
        
        <center><p style="font-family:godfather;color:white;font-size:50px;background-color:darkgoldenrod;">ADD A MOVIE</p></center>
        
        
<form style="padding-left:20px;" method="get" ACTION="/fabflix/employeeAction">
<input type="hidden" name="what" value="add_movie"><br><br>
    <label for="title">Title of movie*</label>
    <input name="title" required><br><br>
    <label for="year">Year of release*</label>
    <input type="number" name="year" required><br><br>
    <label for="director">Director*</label>
    <input name="director" required ><br><br>
    <label for="burl">Banner URL</label>
    <input name="burl" ><br><br>
    <label for="turl">Trailer URL</label>
    <input name="turl" ><br><br>
    <label for="genre">Genre of movie*</label>
    <input name="genre" required><br><br>
    <label for="fname">First name of star*</label>
    <input name="fname" required><br><br>
    <label for="lname">Last name of star*</label>
    <input name="lname" required><br><br>
    <label for="dob">Date of stars birth*</label>
    <input name="dob" value="0000/00/00" required><br><br>
    <label for="purl">Photo URL</label>
    <input name="purl" ><br><br>
<center>
<input style="height:35px" id = "button" type="submit" value="Add Movie"><br><br>
</center>
</form>           
</div>  
    
    
<div id="editmovie">
        
<center><p style="font-family:godfather;color:white;font-size:50px;background-color:darkgoldenrod;">EDIT A MOVIE</p></center>
        
<form style="padding-left:20px;" method="get" ACTION="/fabflix/employeeAction">
<input type="hidden" name="what" value="edit_movie"><br><br>
    <label for="title">Title of movie*</label>
    <input name="title" required><br><br>
    <label for="year">Year of release*</label>
    <input type="number" name="year" required><br><br>
    <label for="director">Director*</label>
    <input name="director" required ><br><br>
    <label for="burl">Banner URL</label>
    <input name="burl"><br><br>
    <label for="turl">Trailer URL</label>
    <input name="turl"><br><br>
    <label for="genre">Genre of movie*</label>
    <input name="genre" required><br><br>
    <label for="fname">First name of star*</label>
    <input name="fname" required><br><br>
    <label for="lname">Last name of star*</label>
    <input name="lname" required><br><br>
    <label for="dob">Date of stars birth*</label>
    <input name="dob" value="0000/00/00" required><br><br>
    <label for="purl">Photo URL</label>
    <input name="purl" ><br><br>
<center>
<input style="height:35px" id = "button" type="submit" value="Edit Movie"><br><br>
</center>
</form>         
</div> 
    

    
    
<div id="addstar">
        
<center><p style="font-family:godfather;color:white;font-size:50px;background-color:darkgoldenrod;">ADD A STAR</p></center>
        
<form style="padding-left:20px;" method="get" ACTION="/fabflix/employeeAction">
<input type="hidden" name="what" value="add_star"><br><br>

    <label for="fname">First name of star*</label>
    <input name="fname" required><br><br>
    <label for="lname">Last name of star*</label>
    <input name="lname" required><br><br>
    <label for="dob">Date of stars birth*</label>
    <input name="dob" value="0000/00/00" required><br><br>
    <label for="purl">Photo URL</label>
    <input name="purl" ><br><br>
<center>
<input style="height:35px" id = "button" type="submit" value="Add Star"><br><br>
</center>
</form>         
</div> 
    

    
<div id="metadata">
        
<center><p style="font-family:godfather;color:white;font-size:50px;background-color:darkgoldenrod;">GET METADATA</p></center>
        
<form style="padding-left:20px;" method="get" ACTION="/fabflix/employeeAction">
<input type="hidden" name="what" value="get_metadata"><br><br>
<center>
<input style="height:35px" id = "button" type="submit" value="Get metadata"><br><br>
</center>
</form>         
</div> 
    
    
    
    
    
    
  
        
    
    
    
    
    
    
    
              

</body>
</html>
