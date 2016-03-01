package com.moviemafia.pikflix;



import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;



import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;


@WebServlet("/typeahead")

public class Typeahead extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");    
		PrintWriter out = response.getWriter();
		String typeahead = "";
		
		try
		{
	
			Context initCtx = new InitialContext();
            if (initCtx == null) out.println ("initCtx is NULL");
		   
	       Context envCtx = (Context) initCtx.lookup("java:comp/env");
           if (envCtx == null) out.println ("envCtx is NULL");
			
	       // Look up our data source
	       DataSource ds = (DataSource) envCtx.lookup("jdbc/TestDB");
	       Connection connection = ds.getConnection();
	       //get the input value and process it.
	       typeahead = request.getParameter("typeahead");
	       //System.out.println(typeahead);
	       String arr[] = typeahead.split("\\s+");
	       String fin = "";
	       boolean space = false;
	       for(String str: arr){
	    	   if(space){
	    		   fin = fin + " ";
	    	   }
	    	   space = true;
	    	    fin = fin + "+*" + str+"*";
	       }
	       
	       //fin = fin + "*";
	       System.out.println(fin);
	       
	       
	       //construct the query in here
	       //String query="SELECT title FROM movies where title like '%"+typeahead+"%' limit 7;";
	       String query = "SELECT title FROM movies WHERE MATCH(title) AGAINST ('"+fin+"' in boolean mode);";
	       
	       
	       //create statements and results using connections
	       Statement statement = connection.createStatement();
	       ResultSet rs = statement.executeQuery(query);
	       
	       
	       
	       
	       out.print("[");
	       boolean set = false;
	       while(rs.next()){
	    	   if(set){
	    		   out.print(",");
	    	   }
	    	   set = true;
	    	   out.print("\"");
	    	   out.print(rs.getString(1));
	    	   out.print("\"");
	       }
	       
	       out.print("]");
	       
	       

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