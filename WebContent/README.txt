Importamt tips and TO:DO before compiling and running WAR file

team 44




1. The source  & class files are in a package called com.moviemafia.pikflix. 
   Their physical location is /var/lib/tomcat7/webapps/fabflix/WEB-INF/classes/com/moviemafia/pikflix


2. the live AWS instance's public IP on which this is deployed is 52.36.253.151 and welcome screen of 
   of the application is accessed via : http://52.36.253.151:8080/fabflix/  or https://52.36.253.151:8443/fabflix
   
3. ASSUMPTIONS taken for the XML parse job:

	1)For duplicate movie titles,we have added it to movies table since its year and director are different
	2)If null 'Firstname' and 'Lastname',given stagename as first_name for actors.xml(stars table)
	3)If 'Firstname' and 'Lastname' tags of actors.xml doesnot exist,given stagename as first_name for actors.xml(stars table)
	4)All Urls in stars and movies table are set null
	
4. The search box has suggestions based on title of the movie, star name and the director name as well 	
	
5. Please make necessary changes to context.xml file as necessary !!!1