# Use Gradle image to build the application
FROM gradle:8.11.1-jdk21 AS builder
WORKDIR /app
COPY . .
RUN gradle build --no-daemon

# Use slim Java image for the runtime
FROM openjdk:21-jdk-slim AS runner
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
