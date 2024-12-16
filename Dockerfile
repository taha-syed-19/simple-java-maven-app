# Use an OpenJDK base image
FROM openjdk:8-jre-alpine

# Expose the application port
EXPOSE 8080

# Set working directory inside the container
WORKDIR /usr/app

# Copy the JAR file to the container
# The JAR file name will match the output from the Maven build in Jenkins
COPY target/*.jar app.jar

# Command to run the application
CMD ["java", "-jar", "app.jar"]
