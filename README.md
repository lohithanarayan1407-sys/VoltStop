# VoltStop – EV Charging Station Management System

## Overview
VoltStop is a Java-based web application designed to manage electric vehicle charging stations, chargers, vehicle information, bookings, and payments.

## Technologies Used
- Java
- Java Servlets
- JSP
- MySQL
- Apache Tomcat
- JDBC
- HTML, CSS, JavaScript
- Eclipse IDE

## Project Structure
- src/main/java/com/voltstop/dao/ – Database access objects
- src/main/java/com/voltstop/model/ – Application model classes
- src/main/java/com/voltstop/servlet/ – Request handling
- src/main/java/com/voltstop/util/ – Database connection utilities
- src/main/webapp/ – JSP pages and web resources
- database/ – SQL database schema

## Database Setup
1. Create a MySQL database named voltstop.
2. Execute database/voltstop_schema.sql.
3. Configure your local database credentials using db.properties.
4. Refer to db.properties.example for the configuration format.

## Running the Project
1. Import the project into Eclipse.
2. Configure your JDK and Apache Tomcat.
3. Add the MySQL Connector/J library.
4. Configure the database connection.
5. Run the project on the Tomcat server.

## Note
This project is intended for educational and demonstration purposes.
