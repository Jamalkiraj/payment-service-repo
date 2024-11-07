# Use a base image with Java installed
FROM openjdk:11-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the built JAR file into the Docker container
COPY target/trial-1.0-SNAPSHOT.jar app.jar

# Expose the application port (optional, if the app uses a specific port)
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]
