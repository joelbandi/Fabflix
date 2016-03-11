package com.moviemafia.pikflix;



import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;


@WebServlet("api/star")

public class MobileStar extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");    
		PrintWriter out = response.getWriter();
		// request parameter extraction here
		String starname = request.getParameter("star");
		String star[] = starname.split("\\s+");

		
		try
		{
		//initiate database context pooling here
			Context initCtx = new InitialContext();
            if (initCtx == null) out.println ("initCtx is NULL");
		   
	       Context envCtx = (Context) initCtx.lookup("java:comp/env");
           if (envCtx == null) out.println ("envCtx is NULL");
			
	       // Look up our data source
	       DataSource ds = (DataSource) envCtx.lookup("jdbc/TestDB");
	       Connection connection = ds.getConnection();

	       
	       
	       //construct the query in here
	       String query = "select * from stars where first_name='"+star[0]+"' and last_name = '"+star[1]+"';";
	       
	       //create statements and results using connections
	       Statement statement = connection.createStatement();
	       ResultSet rs = statement.executeQuery(query);
	       
	       //result processing here
	       rs.next();
	       String starid = rs.getString(1);
	       String first_name = rs.getString(2);
	       String last_name = rs.getString(3);
	       String dob = rs.getString(4);
	       String photo = rs.getString(5);
	       
	       
	       
	       
	     //construct the query in here
	       query = "select title from movies where id= any(select movie_id from stars_in_movies where star_id = "+starid+");";
	       
	       //create statements and results using connections
	       rs = statement.executeQuery(query);
	       
	       //result processing here
	       ArrayList<String> movienames = new ArrayList<String>();
	       while(rs.next()){
	    	   movienames.add(rs.getString(1));
	       }
	       
	       
	       
	       
	       
	       
	       
	       
	       
	       
	       
	       
	       
	       
	       
	       
	       
	       
	       
	       
	       
	       
	       
	       
	       
	       
	       
	       
	       
	       //resource de-allocation here
	       rs.close();
	       statement.close();
	       connection.close();
	       

		}catch (SQLException ex) {
			while (ex != null) {
				System.out.println ("SQL Exception:  " + ex.getMessage ());
				ex = ex.getNextException ();
				return;
			} 
		}  
		
		catch(java.lang.Exception ex)
		{
			System.out.println ("SQL Exception:  " + ex.getMessage ());
			return;
		}
		
		
		
	
		
	}
	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}