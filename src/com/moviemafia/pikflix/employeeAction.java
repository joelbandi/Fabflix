package com.moviemafia.pikflix;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

@WebServlet(description = "pikflix servlet", urlPatterns = { "/employeeAction" })



public class employeeAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException
	{
		String loginUser = "root";
		String loginPasswd = "pikflix";
		String loginUrl = "jdbc:mysql://localhost:3306/moviedb";
		response.setContentType("text/html");    
		PrintWriter out = response.getWriter();
		out.println("<html><head><link href=\"mainpage.css\" rel=\"stylesheet\" /><link href='https://fonts.googleapis.com/css?family=Quattrocento'rel='stylesheet' type='text/css'><meta http-equiv=\"Content-Type\""
				+ "content=\"text/html; charset=UTF-8\"><title>Movie Mafia</title></head><body "
				+ "id=\"mainpage\"><pre>");

		//
		
		try
		{
			//Class.forName("org.gjt.mm.mysql.Driver");
//			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
//			Class.forName("com.mysql.jdbc.Driver").newInstance();
//
//			Connection connection = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
			
			Context initCtx = new InitialContext();
            if (initCtx == null) out.println ("initCtx is NULL");
		   
	       Context envCtx = (Context) initCtx.lookup("java:comp/env");
           if (envCtx == null) out.println ("envCtx is NULL");
			
	       // Look up our data source
	       DataSource ds = (DataSource) envCtx.lookup("jdbc/TestDB");
	       Connection connection = ds.getConnection();
	       
	       /************************/	       
	       if(request.getParameter("what").equals("add_movie")){
	    	   
	    	   String id = request.getParameter("id");
	    	   String title = request.getParameter("title");
	    	   String year = request.getParameter("year");
	    	   String director = request.getParameter("director");
	    	   String burl = request.getParameter("burl");
	    	   String turl = request.getParameter("turl");
	    	   String genre = request.getParameter("genre");
	    	   String fname = request.getParameter("fname");
	    	   String lname = request.getParameter("lname");
	    	   String dob = request.getParameter("dob");
	    	   String purl = request.getParameter("purl");



	    	   CallableStatement cstatement = connection.prepareCall("{call add_movie(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
	    	   cstatement.setString(1, title);
	    	   cstatement.setString(2, year);
	    	   cstatement.setString(3, director);
	    	   cstatement.setString(4, burl);
	    	   cstatement.setString(5, turl);
	    	   cstatement.setString(6, genre);
	    	   cstatement.setString(7, fname);
	    	   cstatement.setString(8, lname);
	    	   cstatement.setString(9, dob);
	    	   cstatement.setString(10, purl);
	    	   cstatement.setString(11,"@a1");
	    	   cstatement.setString(12,"@a3");
	    	   cstatement.setString(13,"@a4");
	    	   cstatement.setString(14,"@a5");
	    	   cstatement.setString(15,"@a6");
	    	   cstatement.setString(16,"@a7");
	    	   cstatement.setString(17,"@a8");
	    	   cstatement.setString(18,"@a2");

	    	   ResultSet rs = cstatement.executeQuery();
	    	   rs.next();
	    	   out.println("<center><p style=\"color:white;font-size:25px;\">"+rs.getString(1)+"</p><br>");
	    	   out.println("<a style=\"color:white;\" href=\"/fabflix/employee.jsp\">go back</a></center");
	    	   
	    	   rs.close();
	       }
	       
	       
	       /************************/	       
	       if(request.getParameter("what").equals("edit_movie")){
	    	   
	    	   String id = request.getParameter("id");
	    	   String title = request.getParameter("title");
	    	   String year = request.getParameter("year");
	    	   String director = request.getParameter("director");
	    	   String burl = request.getParameter("burl");
	    	   String turl = request.getParameter("turl");
	    	   String genre = request.getParameter("genre");
	    	   String fname = request.getParameter("fname");
	    	   String lname = request.getParameter("lname");
	    	   String dob = request.getParameter("dob");
	    	   String purl = request.getParameter("purl");



	    	   CallableStatement cstatement = connection.prepareCall("{call add_movie(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
	    	   cstatement.setString(1, title);
	    	   cstatement.setString(2, year);
	    	   cstatement.setString(3, director);
	    	   cstatement.setString(4, burl);
	    	   cstatement.setString(5, turl);
	    	   cstatement.setString(6, genre);
	    	   cstatement.setString(7, fname);
	    	   cstatement.setString(8, lname);
	    	   cstatement.setString(9, dob);
	    	   cstatement.setString(10, purl);
	    	   cstatement.setString(11,"@a1");
	    	   cstatement.setString(12,"@a3");
	    	   cstatement.setString(13,"@a4");
	    	   cstatement.setString(14,"@a5");
	    	   cstatement.setString(15,"@a6");	
	    	   cstatement.setString(16,"@a7");
	    	   cstatement.setString(17,"@a8");
	    	   cstatement.setString(18,"@a2");

	    	   ResultSet rs = cstatement.executeQuery();
	    	   rs.next();
	    	   out.println("<center><p style=\"color:white;font-size:25px;\">"+rs.getString(1)+"</p><br>");
	    	   out.println("<a style=\"color:white;\" href=\"/fabflix/employee.jsp\">go back</a></center");
	    	   
	    	   rs.close();
	       }

	       
	       
	       /************************/
	       if(request.getParameter("what").equals("get_metadata")){
	    	   Statement statement = connection.createStatement();
	    	   Statement query = connection.createStatement();
	    		ResultSet res = statement.executeQuery("SHOW TABLES");
	    		out.print("<center><pre><p style=\"color:white;font-size:25px;\">");
	            out.println("------------------------------------------------");	
	            while (res.next()) {
	                
	                String table = res.getString(1);
	                out.println("\nTABLE: " + table);
	                ResultSet result = query.executeQuery("Select * from " + table);
	                ResultSetMetaData metadata = result.getMetaData();
	                out.println("\n" + "There are "+ metadata.getColumnCount()+ " columns in this table.");
	                for (int i = 1; i <= metadata.getColumnCount(); i++) {
	                    out.println( i + ". " + metadata.getColumnName(i) + " of type " + metadata.getColumnTypeName(i));
	                }
	                out.println("------------------------------------------------");	
	            }
	            out.println();
	            
	            out.println("<a style=\"color:white;\" href=\"/fabflix/employee.jsp\">go back</a></pre></center");
	    	   res.close();
	    	   statement.close();
	    	   query.close();
	       }
	       
	       
	       /************************/
	       if(request.getParameter("what").equals("add_star")){
	    	   
	    	   String fname = request.getParameter("fname");
	    	   String lname = request.getParameter("lname");
	    	   String starid = request.getParameter("starid");
	    	   String dob = request.getParameter("dob");
	    	   String purl = request.getParameter("purl");
	    	   
	    	   if(fname!="" && lname ==""){
	    		   lname = fname;
	    		   fname="";
	    		   
	    	   }
	    	   
	    	   Statement statement = connection.createStatement();
	    	   
	    	   
	    	   ResultSet rs = statement.executeQuery("select count(first_name) from stars where first_name = '"+fname+"' and last_name = '"+lname+"'");
	    	   rs.next();
	    	   System.out.println(rs.getString(1));
	    	   if(rs.getString(1).equals("0")){
	    		   statement.executeUpdate("INSERT INTO stars VALUES("
	    				   + starid + ", '"
	    				   + fname + "', '"
	    				   + lname + "', DATE('"
	    				   + dob + "'), '"
	    				   + purl + "');");

	    		   System.out.println("Star "+fname+" "+lname+" successfully added");
	    		   
	    		   out.println("<center><p style=\"color:white;font-size:25px;\">"+"Star "+fname+" "+lname+" successfully added"+"</p><br>");
		    	   out.println("<a style=\"color:white;\" href=\"/fabflix/employee.jsp\">go back</a></center");
	    		   rs.close();
	    		   statement.close();
	    	   }else{
	    		   System.out.println("Star exists already");
	    		   out.println("<center><p style=\"color:white;font-size:25px;\">"+"Star exists already"+"</p><br>");
		    	   out.println("<a style=\"color:white;\" href=\"/fabflix/employee.jsp\">go back</a></center");
	    	   }  
	       }
	      
	       
	       out.print("</pre></body></html>");
	       
	       
	       
		
		}

		catch (SQLException ex) {
			while (ex != null) {
				System.out.println ("SQL Exception:  " + ex.getMessage ());
				out.println("<P>SQL error in doGet: " +
						ex.getMessage() + "</P></BODY></HTML>");
				ex = ex.getNextException ();
			}  // end while
		}  // end catch SQLException

		catch(java.lang.Exception ex)
		{
			out.println("<P>SQL error in doGet: " +
					ex.getMessage() + "</P></BODY></HTML>");
			ex.printStackTrace();
			return;
		}
		out.println("</body></html>");
		out.close();
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException{
		doGet(request,response);
	}

}

