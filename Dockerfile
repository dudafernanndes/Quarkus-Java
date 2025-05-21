
FROM eclipse-temurin:17-jdk AS build
WORKDIR /work/
COPY . /work/
RUN ./mvnw clean package -DskipTests

FROM eclipse-temurin:17-jre
WORKDIR /app/
COPY --from=build /work/target/*-runner.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
