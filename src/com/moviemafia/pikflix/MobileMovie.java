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

import org.json.JSONArray;
import org.json.JSONObject;


@WebServlet("/api/movie")

public class MobileMovie extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");    
		PrintWriter out = response.getWriter();
		// request parameter extraction here
		String movie = request.getParameter("movie");
		
		
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
	       String query = "Select * from movies where title = '"+movie+"';";
	       
	       
	       
	       
	       
	       //create statements and results using connections
	       Statement statement = connection.createStatement();
	       ResultSet rs = statement.executeQuery(query);
	       
	     //result processing
	       rs.next();
	       
	       String movieid = rs.getString(1);
	       String title = rs.getString(2);
	       String year = rs.getString(3);
	       String director = rs.getString(4);
	       String banner = rs.getString(5);
	       String trailer = rs.getString(6);
	       
	       
	     //construct the query in here
	       query = "Select first_name,last_name from stars where id = any(select star_id from stars_in_movies where movie_id = "+movieid+");";
	       

	       //create statements and results using connections
	       rs = statement.executeQuery(query);
	       
	     //result processing
	       ArrayList<String> starnames = new ArrayList<String>();
	       while(rs.next()){
	    	   String name = rs.getString(1) +" "+rs.getString(2);
	    	   starnames.add(name);
	    	   
	       }
	       
	       
	       
	       
	       
	     //construct the query in here
	       query = "Select name from genres where id = any(select star_id from stars_in_movies where movie_id = "+movieid+");";

	       
	       //create statements and results using connections
	       rs = statement.executeQuery(query);
	       
	       
	     //result processing
	       ArrayList<String> genrenames = new ArrayList<String>();
	       while(rs.next()){
	    	   genrenames.add(rs.getString(1));
	    	   
	       }
	       
	       
	       
	       
	       
	       
	       
	       
	     //JSON construction
	       
	       JSONArray stararray = new JSONArray(starnames);
	       JSONArray genrearray = new JSONArray(genrenames);
	       JSONObject jsonresult = new JSONObject();
	       jsonresult.put("id", movieid);
	       jsonresult.put("title", title);
	       jsonresult.put("year", year);
	       jsonresult.put("director", director);
	       jsonresult.put("banner",banner);
	       jsonresult.put("trailer", trailer);
	       jsonresult.put("starnames",stararray);
	       jsonresult.put("genrenames",genrearray);
	       
	       
	       out.println(jsonresult);
	        
	       
	       //resource de-allocation here
	       rs.close();
	       statement.close();
	       connection.close();
	       out.flush();
	       out.close();
	       

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