FROM maven:3-eclipse-temurin-21 as builder

COPY pom.xml pom.xml
COPY src src

RUN mvn clean install

FROM eclipse-temurin:21

WORKDIR /app

COPY --from=builder /target/*.jar main.jar

EXPOSE 8080

# Define the command to run your React app
CMD ["java", "-jar", "main.jar"]