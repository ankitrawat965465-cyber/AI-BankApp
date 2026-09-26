<div align="center">

# AI BankApp — Docker & DevOps Project

A Spring Boot banking application containerized and configured with MySQL for local development. The main focus of this project is the DevOps implementation around the application.

[![Java Version](https://img.shields.io/badge/Java-21-blue.svg)](https://www.oracle.com/java/technologies/javase/jdk21-archive-downloads.html)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.4.1-brightgreen.svg)](https://spring.io/projects/spring-boot)

![dashboard](01-dashboard.png)

</div>



---

## Technical Architecture

Architecture
Browser
   |
   | HTTP :8080
   v
Docker Container
Spring Boot Application
   |
   | host.docker.internal:3306
   v
MySQL on Host Machine
   |
   v
bankappdb
   |
   +-- accounts
   |
   +-- transactions

### Phase 3: Secrets and Pipeline Configuration

Docker

Build the image:

docker build -t ai-bankapp:latest .

Run the application:

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

Application:

http://localhost:8080
  ```
Database Configuration

The application uses MySQL 8 as the database.

Database Details
Database Host  : host.docker.internal
Database Port  : 3306
Database Name  : bankappdb
Database User  : bankapp
Database Password : <your-password>

The Docker container connects to MySQL running on the host machine using:

host.docker.internal
Environment Variables

The Spring Boot application receives the database configuration through environment variables:

MYSQL_HOST=host.docker.internal
MYSQL_PORT=3306
MYSQL_DATABASE=bankappdb
MYSQL_USER=bankapp
MYSQL_PASSWORD=<your-password>

For local testing, the password is supplied through the environment and is not stored in the Git repository.

MySQL User Configuration

A separate MySQL user was created for the application:

CREATE USER 'bankapp'@'%' IDENTIFIED BY '<your-password>';

GRANT ALL PRIVILEGES ON bankappdb.* TO 'bankapp'@'%';

FLUSH PRIVILEGES;

This allows the Dockerized Spring Boot application to access the bankappdb database.

Database Structure

The application uses the following database:

bankappdb

Main tables:

accounts
transactions

The accounts table stores user account information, while the transactions table is used for transaction-related data.

Verification
1. Check Docker Container
docker ps

The application container should be running:

ai-bankapp
2. Check Application Logs
docker logs ai-bankapp

Successful database connectivity can be verified from the Spring Boot/HikariCP logs.

Example:

HikariPool-1 - Start completed.
Database version: 8.0.46
3. Check MySQL Database

Login to MySQL:

mysql -u root -p

Select the application database:

USE bankappdb;

Check tables:

SHOW TABLES;

Expected tables include:

accounts
transactions

Check account data:

SELECT * FROM accounts;

This verifies that data created through the Spring Boot application is successfully stored in MySQL.
  
