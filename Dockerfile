# Start with a base image - in this case JDK 8 Alpine
FROM openjdk:8-jdk-alpine
# Run as a non-root user to mitigate security risks
# https://security.stackexchange.com/questions/106860/can-a-root-user-inside-a-docker-lxc-break-the-security-of-the-whole-system
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring
# Specify JAR location
ARG JAR_FILE=target/*.jar
# Copy the JAR
COPY ${JAR_FILE} simply-schedule-0.0.1-SNAPSHOT.jar
# Set ENTRYPOINT in exec form to run the container as an executable
ENTRYPOINT ["java", "-Dspring.profiles.active=prod" ,"-Djasypt.encryptor.password=1a2b3c4d","-jar","/simply-schedule-0.0.1-SNAPSHOT.jar"]
# Expose port 8080 to hit the api
EXPOSE 8080