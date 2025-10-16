FROM maven:3-eclipse-temurin-21 AS builder

COPY pom.xml pom.xml
COPY src src
ENV MAVEN_ARGS=-ntp

RUN mvn clean install

FROM eclipse-temurin:21

WORKDIR /app

COPY --from=builder /target/*.jar main.jar

EXPOSE 8080

CMD ["java", "-jar", "main.jar"]
