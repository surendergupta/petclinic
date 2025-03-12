# Stage 1: Build the application using Maven 3.9 and JDK 17
FROM maven:3.9.6-eclipse-temurin-17 AS builder

# Set the working directory
WORKDIR /app

# Copy the source code
COPY . .

# Build the WAR file (skipping tests)
RUN mvn clean package -DskipTests

# Stage 2: Deploy the WAR to Tomcat
FROM tomcat:9.0-jdk17-temurin


# Copy the WAR file from the builder stage
COPY --from=builder /app/target/petclinic.war /usr/local/tomcat/webapps/

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
# Access http://<IPADDRESS>:8080/petclinic