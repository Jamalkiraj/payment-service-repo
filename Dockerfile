# Use a base image for Java
FROM openjdk:11-jre-slim as builder

# Set the working directory
WORKDIR /app

# Copy the Java application source code
COPY src/main/java/com/example /app/src/main/java/com/example

# Install Maven if not already included in the base image
RUN apt-get update && apt-get install -y maven

# Build the Java application (replace with your actual build command)
RUN mvn clean package

# Use nginx to serve the application
FROM nginx:alpine

# Install ngrok
RUN apk add --no-cache curl \
    && curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | tee /etc/apk/keys/ngrok.asc \
    && echo "https://ngrok-agent.s3.amazonaws.com/alpine/latest" >> /etc/apk/repositories \
    && apk add ngrok

# Copy the built Java app into the nginx directory
COPY --from=builder /app/target/app.jar /usr/share/nginx/html/app.jar

# Expose ports
EXPOSE 80

# Start both nginx and ngrok
CMD /bin/sh -c "nginx && ngrok http 80"

