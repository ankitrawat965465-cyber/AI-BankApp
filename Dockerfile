# Java 21 JDK base image use kar rahe hain
FROM eclipse-temurin:21-jdk-jammy

# Container ke andar /app ko working directory bana rahe hain
WORKDIR /app

# Current directory ki saari files container ke /app mein copy kar rahe hain
COPY . .

# Maven Wrapper ko executable permission de rahe hain
# Phir application ko build/package kar rahe hain
# -DskipTests = tests skip karo
# -B = batch mode
RUN chmod +x mvnw && ./mvnw clean package -DskipTests -B

# Application ke liye port 8080 indicate kar rahe hain
EXPOSE 8080

# Container start hone par Java JAR application run hogi
# sh -c ka use *.jar wildcard ko expand karne ke liye kiya hai
ENTRYPOINT ["sh", "-c", "java -jar target/*.jar"]