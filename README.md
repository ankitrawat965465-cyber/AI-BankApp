<div align="center">

# AI BankApp — Docker & DevOps Project

A Spring Boot banking application containerized and configured with MySQL for local development. The main focus of this project is the DevOps implementation around the application.

[![Java Version](https://img.shields.io/badge/Java-21-blue.svg)](https://www.oracle.com/java/technologies/javase/jdk21-archive-downloads.html)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.4.1-brightgreen.svg)](https://spring.io/projects/spring-boot)

![dashboard](01-dashboard.png)

</div>

Project Overview

AI BankApp is a Spring Boot banking application that has been containerized using Docker.

The application runs inside a Docker container while MySQL runs on the host machine. The container communicates with the host MySQL server using:

host.docker.internal

The database configuration is passed to the application through environment variables instead of storing the database password directly in the Git repository.

Main DevOps Concepts Implemented
Java 21 application
Spring Boot application
Docker image creation
Docker container management
Docker networking
Environment variables
MySQL 8 database connectivity
Separate MySQL application user
Database permissions
Container logs and troubleshooting
Application and database verification
Git and GitHub version control
Architecture
                    Browser
                       |
                       | HTTP :8080
                       |
                       v
              +-------------------+
              |   Docker Container |
              |                   |
              | Spring Boot App   |
              |     Java 21       |
              +---------+---------+
                        |
                        | host.docker.internal:3306
                        |
                        v
              +-------------------+
              |   MySQL 8         |
              | Host Machine      |
              +---------+---------+
                        |
                        v
                    bankappdb
                   /         \
                  /           \
           accounts       transactions
Technology Stack
Technology	Purpose
Java 21	Application runtime
Spring Boot	Backend application
MySQL 8	Database
Docker	Application containerization
Git	Version control
GitHub	Source code repository
Linux	Development environment
Project Structure
AI-BankApp-DevOps/
│
├── src/
│   └── main/
│       └── resources/
│           └── application.properties
│
├── Dockerfile
├── pom.xml
├── mvnw
├── README.md
│
├── 01-dashboard.png
├── 02-dashboard.png
└── 03-application.png
Docker Implementation
Docker Image

The application is packaged into a Docker image:

docker build -t ai-bankapp:latest .

Verify the image:

docker images

Expected image:

ai-bankapp
Running the Container

The application container is started using:

docker run -d \
  --name ai-bankapp \
  --add-host=host.docker.internal:host-gateway \
  -p 8080:8080 \
  -e MYSQL_HOST=host.docker.internal \
  -e MYSQL_PORT=3306 \
  -e MYSQL_DATABASE=bankappdb \
  -e MYSQL_USER=bankapp \
  -e MYSQL_PASSWORD=<your-password> \
  ai-bankapp:latest
What these options do
Option	Purpose
-d	Runs container in background
--name ai-bankapp	Gives the container a name
-p 8080:8080	Maps host port 8080 to container port 8080
--add-host	Allows the container to reach the host machine
-e	Passes environment variables
MYSQL_HOST	MySQL hostname
MYSQL_DATABASE	Database name
MYSQL_USER	Application database user
MYSQL_PASSWORD	Database password
Application

After starting the container, open:

http://localhost:8080

The Spring Boot application is served from the Docker container.

Application Screenshot




Database Configuration

The application uses MySQL 8.

Configuration	Value
Database Host	host.docker.internal
Database Port	3306
Database Name	bankappdb
Database User	bankapp
Password	Supplied through environment variable

The Docker container connects to MySQL running on the host machine through:

host.docker.internal:3306
Environment Variables

Database configuration is supplied using environment variables:

MYSQL_HOST=host.docker.internal
MYSQL_PORT=3306
MYSQL_DATABASE=bankappdb
MYSQL_USER=bankapp
MYSQL_PASSWORD=<your-password>

The database password is not stored directly in the Git repository.

This allows the same application image to be used with different database credentials without modifying the application source code.

MySQL User Configuration

A separate MySQL user was created for the application instead of using the root account.

CREATE USER 'bankapp'@'%' IDENTIFIED BY '<your-password>';

GRANT ALL PRIVILEGES ON bankappdb.* TO 'bankapp'@'%';

FLUSH PRIVILEGES;

This user is used by the Dockerized Spring Boot application to access:

bankappdb
Database Structure

The application database is:

bankappdb

Main tables:

accounts
transactions

The accounts table stores banking account information.

The transactions table is used for transaction-related information.

Database Screenshot




Verification & Testing
1. Check Docker Container
docker ps

The application container should be running:

ai-bankapp
2. Check Application Logs
docker logs ai-bankapp

Successful database connectivity can be verified through the Spring Boot and HikariCP logs.

Example:

HikariPool-1 - Start completed.
Database version: 8.0.46
3. Check MySQL Database

Login to MySQL:

mysql -u root -p

Select the application database:

USE bankappdb;

Check the tables:

SHOW TABLES;

Expected tables:

accounts
transactions

Check account data:

SELECT * FROM accounts;

This verifies that data created through the Spring Boot application is successfully stored in MySQL.

Docker → MySQL Connectivity

The complete flow is:

Browser
   |
   | :8080
   v
Docker Container
   |
   | Spring Boot
   |
   | host.docker.internal:3306
   v
MySQL Host Machine
   |
   v
bankappdb

This setup demonstrates communication between a containerized application and a database running outside the container.

Screenshots
Application Dashboard




Database




Application




What I Learned From This Project

Through this project, I practiced:

Creating and modifying a Dockerfile
Building Docker images
Running Docker containers
Port mapping
Docker-to-host networking
Using environment variables for configuration
Connecting a containerized Spring Boot application to MySQL
Creating a dedicated MySQL application user
Managing MySQL permissions
Checking Docker logs
Troubleshooting database connectivity
Verifying application data in MySQL
Using Git and GitHub for version control
Future Improvements

The project can be extended with additional DevOps practices such as:

CI/CD using GitHub Actions
Docker image security scanning
Docker image publishing
AWS deployment
Infrastructure as Code
Kubernetes deployment
Monitoring and logging

These are planned improvements and are not part of the current implementation.

Author

Ankit Rawat

DevOps / Telecom & GIS Professional

GitHub:
https://github.com/ankitrawat965465-cyber
