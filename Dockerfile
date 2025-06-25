# Use a lightweight JDK base image
FROM openjdk:21

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file into the container
COPY target/Docker_Demo_With_Springboot.jar /app/

# Expose the port your app will run on
EXPOSE 8080

# Run the jar file
ENTRYPOINT ["java", "-jar", "Docker_Demo_With_Springboot.jar"]
