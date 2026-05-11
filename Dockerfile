# Use lightweight Java 11 runtime
FROM eclipse-temurin:11-jre

# Application directory inside container
WORKDIR /app

# Copy generated jar file
COPY target/app.jar app.jar

# Expose application port
EXPOSE 8080

# Start application
ENTRYPOINT ["java", "-jar", "app.jar"]
