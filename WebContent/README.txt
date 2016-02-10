Importamt tips and TO:DO before compiling and running WAR file

team 44


1. Rename this war file as PikflixWeb (please note the capitalization of P and W)
   as this project is named PikflixWeb instead of fablix 

2. Everytime you want to access reports like for xample "locahost:8080/fabflix/reports/signature" use intead 
   "localhost:8080/PikflixWeb/reports/signature" as our project is named PikFlixWeb we have used absolute paths throughout our project and 
   refactoring them will be a big problem (sorry about this)

3. the source  & class files are in a package called com.moviemafia.pikflix.


4. the AWS instance's public IP on which this is deployed is 52.26.11.176 and the homepage 
   of the application is accessed via : http://52.26.11.176:8080/PikflixWeb/