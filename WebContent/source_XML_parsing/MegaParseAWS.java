

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.ResultSet;
import com.mysql.jdbc.Statement;

public class MegaParseAWS {

	// JDBC driver name and database URL
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	static final String DB_URL = "jdbc:mysql://localhost/moviedb_project4_grading";

	//  Database credentials
	static final String USER = "classta";
	static final String PASS = "classta";

	static int id1;
	static int id2;
	static int id3;


	public static void main(String[] args) throws SAXException, IOException, ParserConfigurationException {
		try{
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			System.out.println("Connecting to database...");
			java.sql.Connection conn_a = DriverManager.getConnection(DB_URL,USER,PASS);
			java.sql.Statement stmt_a = conn_a.createStatement();
			ResultSet idMax_a = (ResultSet) stmt_a.executeQuery("SELECT MAX(id) as max_id FROM movies;");

			if (idMax_a.next()) {
				id1 = idMax_a.getInt("max_id");  
				System.out.println("Max movie id from DB: "+id1);
			}

			stmt_a.close();
			conn_a.close();

			java.sql.Connection conn_b = (Connection)DriverManager.getConnection(DB_URL,USER,PASS);
			java.sql.Statement stmt_b = conn_b.createStatement();
			ResultSet idMax_b = (ResultSet) stmt_b.executeQuery("SELECT MAX(id) as max_id FROM stars;");

			if (idMax_b.next()) {
				id2 = idMax_b.getInt("max_id");  
				System.out.println("Max star id from DB: "+id2);
			}

			stmt_b.close();
			conn_b.close();

			java.sql.Connection conn_c = DriverManager.getConnection(DB_URL,USER,PASS);
			java.sql.Statement stmt_c = conn_c.createStatement();
			ResultSet idMax_c = (ResultSet) stmt_c.executeQuery("SELECT MAX(id) as max_id FROM genres;");

			if (idMax_c.next()) {
				id3 = idMax_c.getInt("max_id");  
				System.out.println("Max genre id from DB: "+id3);
			}

			stmt_c.close();
			conn_c.close();


		}catch(SQLException se){
			//Handle errors for JDBC
			se.printStackTrace();
		}catch(Exception e){
			//Handle errors for Class.forName
			e.printStackTrace();
		}
		//System.out.println("Goodbye!");


		HashMap<String,Integer>genreMap=showGenres();
		HashMap<String,Integer>movieMap=showMovies();
		HashMap<String,Integer>starMap=showStars();
		HashMap<String, ArrayList<String>>castMap=showCasts();
		setGenresInMovies(genreMap);

		File f = new File("./final_stars_in_movies.txt");
		FileWriter file;
		BufferedWriter buff;
		file = new FileWriter(f, false);
		buff = new BufferedWriter(file);
		ArrayList<String> stage1 = new ArrayList<>();;

		//System.out.println(movieMap);
		for(String i :movieMap.keySet()){
			int starId1 = 0;
			int movieId1 = 0;
			if(castMap.containsKey(i)){
				stage1 =castMap.get(i);
			}


			try{for(String str:stage1){
				if((starMap.containsKey(str))){
					starId1 = starMap.get(str);
				} 
//				else{
//					starId1 = 1234;
//				}

				//if(starId1!=1234){
					movieId1=movieMap.get(i);
					file = new FileWriter(f, true);
					buff = new BufferedWriter(file);
					//System.out.println(starId1+","+movieId1);
					//System.out.println("------------------");
					buff.write(starId1+","+movieId1);
					buff.newLine();
					buff.close();		
				//}
			}}catch(Exception e){e.printStackTrace();}
			stage1.clear();
			//			for(String str:stage1){
			//				if((starMap.containsKey(str))&& ((str!=null))||(str!="")){
			//					starId1 = starMap.get(str);
			//				} else{
			//					starId1 = 1234;
			//				}
			//
			//				if(starId1!=1234){
			//					movieId1=movieMap.get(i);
			//					file = new FileWriter(f, true);
			//					buff = new BufferedWriter(file);
			//					System.out.println(starId1+","+movieId1);
			//					System.out.println("------------------");
			//					buff.write(starId1+","+movieId1);
			//					buff.newLine();
			//					buff.close();		
			//				}
			//			}
		}







		try{
			Class.forName("com.mysql.jdbc.Driver").newInstance();

			System.out.println("Connecting to database...");
			java.sql.Connection conn1 = DriverManager.getConnection(DB_URL,USER,PASS);
			java.sql.Statement stmt1 = conn1.createStatement();
			String sql1;
			sql1 = "LOAD DATA LOCAL INFILE './final_movies.txt' INTO TABLE movies FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';";
			boolean rs1 = stmt1.execute(sql1);
			stmt1.close();
			conn1.close();

			java.sql.Connection conn2 = DriverManager.getConnection(DB_URL,USER,PASS);
			java.sql.Statement stmt2 = conn2.createStatement();
			String sql2;
			sql2 = "LOAD DATA LOCAL INFILE './final_stars.txt' INTO TABLE stars FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';";
			boolean rs2 = stmt2.execute(sql2);
			stmt2.close();
			conn2.close();

			java.sql.Connection conn3 = DriverManager.getConnection(DB_URL,USER,PASS);
			java.sql.Statement stmt3= conn3.createStatement();
			String sql3;
			sql3 = "LOAD DATA LOCAL INFILE './final_genres.txt' INTO TABLE genres FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';";
			boolean rs3 = stmt3.execute(sql3);
			stmt3.close();
			conn3.close();

			java.sql.Connection conn4 = DriverManager.getConnection(DB_URL,USER,PASS);
			java.sql.Statement stmt4= conn4.createStatement();
			String sql4;
			sql4 = "LOAD DATA LOCAL INFILE './final_stars_in_movies.txt' INTO TABLE stars_in_movies FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';";
			boolean rs4 = stmt4.execute(sql4);
			stmt4.close();
			conn4.close();

			java.sql.Connection conn5 = DriverManager.getConnection(DB_URL,USER,PASS);
			java.sql.Statement stmt5= conn5.createStatement();
			String sql5;
			sql5 = "LOAD DATA LOCAL INFILE './final_GenreInMovies.txt' INTO TABLE genres_in_movies FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';";
			boolean rs5 = stmt5.execute(sql5);
			stmt5.close();
			conn5.close();


		}catch(SQLException se){
			//Handle errors for JDBC
			se.printStackTrace();
		}catch(Exception e){
			//Handle errors for Class.forName
			e.printStackTrace();
		}
		System.out.println("DONE......!");

	}

	private static void setGenresInMovies(HashMap<String,Integer> genreMap)throws IOException, SAXException, ParserConfigurationException{

		HashMap<String,Integer>movieMap=new HashMap<>();
		File f = new File("./final_GenreInMovies.txt");
		FileWriter file;
		BufferedWriter buff;
		file = new FileWriter(f, false);
		buff = new BufferedWriter(file);


		//DOM PARSER INSTANCE
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder documentBuilder = factory.newDocumentBuilder();
		Document document = documentBuilder.parse(ClassLoader.getSystemResourceAsStream("XML/mains243.xml"));
		Element root = document.getDocumentElement();
		System.out.println("Parsing...."+root.getNodeName());


		NodeList FilmsList = document.getElementsByTagName("film");
		int i=id1+1;	
		for(int k=0; k< FilmsList.getLength();k++){
			Node node2=FilmsList.item(k);

			if(node2.getNodeType()==Node.ELEMENT_NODE){

				Element eElement = (Element) node2;
				String fid=null;
				String genre = null;


				try {
					fid=eElement.getElementsByTagName("fid").item(0).getTextContent();			
				} catch (NullPointerException e) {
					fid=eElement.getElementsByTagName("filmed").item(0).getTextContent();
				}


				try {
					genre = eElement.getElementsByTagName("cat").item(0).getTextContent();
				} catch (NullPointerException e) {
					genre="NA";
				}				



				if(genreMap.containsKey(genre)){
					int genId=genreMap.get(genre);
					buff.write(genId+","+i);
					buff.newLine();

				}



				//System.out.println("Writing: "+k);


			}
			i++;
		}


	}

	private static HashMap<String,Integer> showGenres() throws IOException, SAXException, ParserConfigurationException {
		HashSet<String>genreSet=new HashSet<>();
		HashMap<String,Integer>genreMap=new HashMap<>();
		File f = new File("./final_genres.txt");
		FileWriter file;
		BufferedWriter buff;
		file = new FileWriter(f, false);
		buff = new BufferedWriter(file);

		//DOM PARSER INSTANCE
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder documentBuilder = factory.newDocumentBuilder();
		Document document = documentBuilder.parse(ClassLoader.getSystemResourceAsStream("XML/mains243.xml"));


		Element root = document.getDocumentElement();
		//System.out.println("Parsing......"+root.getNodeName());

		NodeList FilmsList = document.getElementsByTagName("film");
		for(int k=0; k< FilmsList.getLength();k++){
			Node node2=FilmsList.item(k);
			if(node2.getNodeType()==Node.ELEMENT_NODE){

				Element eElement = (Element) node2;

				String genre=null;

				try {
					genre=eElement.getElementsByTagName("cat").item(0).getTextContent();			
				} catch (NullPointerException e) {
					continue;
				}

				genreSet.add(genre);

			}

		}int i=id3+1;


		for(String str:genreSet){
			file = new FileWriter(f, true);
			buff = new BufferedWriter(file);
			//System.out.println(i+","+str);
			genreMap.put(str,i);
			buff.write(i+","+str);
			i++;
			buff.newLine();
			buff.close();

		}
		return genreMap;

	}

	public static HashMap<String,Integer> showMovies() throws SAXException, IOException, ParserConfigurationException{
		HashMap<String,Integer>movieMap=new HashMap<>();

		File f = new File("./final_movies.txt");
		FileWriter file;
		BufferedWriter buff;
		file = new FileWriter(f, false);
		buff = new BufferedWriter(file);

		//DOM PARSER INSTANCE
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder documentBuilder = factory.newDocumentBuilder();
		Document document = documentBuilder.parse(ClassLoader.getSystemResourceAsStream("XML/mains243.xml"));





		Element root = document.getDocumentElement();
		System.out.println("Parsing...."+root.getNodeName());


		NodeList FilmsList = document.getElementsByTagName("film");
		int i=id1+1;	
		for(int k=0; k< FilmsList.getLength();k++){
			Node node2=FilmsList.item(k);



			if(node2.getNodeType()==Node.ELEMENT_NODE){
				file = new FileWriter(f, true);
				buff = new BufferedWriter(file);
				Element eElement = (Element) node2;

				String title=null;
				String director = null;
				String year = null;
				String fid=null;
				String genre = null;

				title=eElement.getElementsByTagName("t").item(0).getTextContent();



				try {
					fid=eElement.getElementsByTagName("fid").item(0).getTextContent();			
				} catch (NullPointerException e) {
					fid=eElement.getElementsByTagName("filmed").item(0).getTextContent();
				}


				try {
					year = eElement.getElementsByTagName("year").item(0).getTextContent();
				} catch (NullPointerException e) {
					year = "0000";
				}

				if(year.length()>4){
					year=year.substring(0, 5);
				}


				try {
					director = eElement.getElementsByTagName("dirn").item(0).getTextContent();
				} catch (NullPointerException  e) {
					director="\\N";
				}



				buff.write(i+","+title+","+year+","+director+","+"\\N"+","+"\\N");
				buff.newLine();
				buff.close();

				//System.out.println("Writing: "+i);

				movieMap.put(fid, i);

			}
			i++;
		}

		return movieMap;

	}

	public static HashMap<String,Integer> showStars() throws SAXException, IOException, ParserConfigurationException{
		HashMap<String,Integer>starstar=new HashMap<>();
		File f = new File("./final_stars.txt");
		FileWriter file;
		BufferedWriter buff;
		file = new FileWriter(f, false);
		buff = new BufferedWriter(file);

		//TO GET STARS FROM XML
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder documentBuilder = factory.newDocumentBuilder();
		Document document = documentBuilder.parse(ClassLoader.getSystemResourceAsStream("XML/actors63.xml"));
		//Stars star = new Stars();

		Element root = document.getDocumentElement();
		System.out.println("Parsing....."+root.getNodeName());

		NodeList actorList = document.getElementsByTagName("actor");
		int k= id2+1;
		for(int i=0; i< actorList.getLength(); i++){
			Node node2=actorList.item(i);




			if(node2.getNodeType()==Node.ELEMENT_NODE){
				Element eElement = (Element) node2;
				file = new FileWriter(f, true);
				buff = new BufferedWriter(file);
				//System.out.println("Star # "+i);

				String firstName = null;
				String lastName = null;
				String dob=null;
				String stageName=null;
				try {
					firstName = eElement.getElementsByTagName("firstname").item(0).getTextContent().toLowerCase();
				} catch (NullPointerException e) {
					firstName = eElement.getElementsByTagName("stagename").item(0).getTextContent().toLowerCase();

				}




				try {
					lastName = eElement.getElementsByTagName("familyname").item(0).getTextContent().toLowerCase();
				} catch (NullPointerException  e) {
					lastName = "";

				}


				try {
					stageName = eElement.getElementsByTagName("stagename").item(0).getTextContent().toLowerCase();
				} catch (NullPointerException  e) {
					stageName = "Not Available";

				}

				try {
					dob = eElement.getElementsByTagName("dob").item(0).getTextContent();
				} catch (NullPointerException e) {
					dob="0000";				
				}


				if(firstName=="" && lastName==""){
					firstName=stageName;
				}

				if(dob==""){
					dob="0000";
				}

				starstar.put(stageName,k);
				buff.write(k+","+firstName+","+lastName+","+dob+","+"\\N");
				buff.newLine();
				buff.close();

			}k++;
		}//System.out.println(starstar);
		return starstar;
	}

	public static HashMap<String,ArrayList<String>> showCasts() throws SAXException, IOException, ParserConfigurationException{
		HashMap<String,ArrayList<String>>moviestar=new HashMap<>();

		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder documentBuilder = factory.newDocumentBuilder();
		Document document = documentBuilder.parse(ClassLoader.getSystemResourceAsStream("XML/casts124.xml"));

		Element root = document.getDocumentElement();
		System.out.println("Making Connections in stars and genres...");

		NodeList castsList = document.getElementsByTagName("m");

		for(int i=0; i< castsList.getLength(); i++){
			Node node2=castsList.item(i);




			if(node2.getNodeType()==Node.ELEMENT_NODE){
				Element eElement = (Element) node2;
				//System.out.println("Entry # "+i);
				String movieName = null;
				String stageName=null;
				String fid=null;
				try {
					movieName = eElement.getElementsByTagName("t").item(0).getTextContent();
				} catch (NullPointerException e) {
					movieName = "";

				}
				//String fid1=fid;
				try {
					fid = eElement.getElementsByTagName("f").item(0).getTextContent();
				} catch (NullPointerException e) {
					fid = "";

				}

				try {
					stageName = eElement.getElementsByTagName("a").item(0).getTextContent().toLowerCase();
				} catch (NullPointerException  e) {
					stageName = null;

				}

				if(moviestar.containsKey(fid)){
					moviestar.get(fid).add(stageName);
				}
				else{
					ArrayList<String>val=new ArrayList<>();
					val.add(stageName);
					moviestar.put(fid, val);
				}

				//System.out.println(fid+"---->"+moviestar.get(fid));


			}
		}//System.out.println(moviestar);
		return moviestar;

	}

}
