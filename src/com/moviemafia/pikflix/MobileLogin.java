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


@WebServlet("/api/login")

public class MobileLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");    
		PrintWriter out = response.getWriter();
		String email = "";
		String pass  = "";
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
	       email = request.getParameter("email");
	       pass = request.getParameter("pass");
	       
	       
	       
	       //construct the query in here
	       String query = "Select * from customers where email = '"+email+"';";
	       
	       
	       //create statements and results using connections
	       Statement statement = connection.createStatement();
	       ResultSet rs = statement.executeQuery(query);
	       while(rs.next()){
	    	   if(rs.getString(7).equals(pass)){
	    		   out.println("true");
	    		   rs.close();
	    		   statement.close();
	    		   connection.close();
	    		   return;
	    	   }else{
	    		   out.println("false");
	    		   rs.close();
	    		   statement.close();
	    		   connection.close();
	    		   return;
	    	   }
	       }
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