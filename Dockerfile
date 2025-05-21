# Etapa de build
FROM eclipse-temurin:17-jdk AS build
WORKDIR /work/

# Instala Maven e compila o projeto
RUN apt update && apt install -y maven
COPY . /work/
RUN mvn clean package -DskipTests

# Etapa de execução
FROM eclipse-temurin:17-jre
WORKDIR /app/
COPY --from=build /work/target/*-runner.jar /app/app.jar

# Railway usará a porta definida por $PORT, com fallback para 8080
ENV PORT=8080
EXPOSE ${PORT}

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
