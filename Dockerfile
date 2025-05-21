# Etapa de build
FROM eclipse-temurin:17-jdk AS build
WORKDIR /work/

# Copia tudo, mas garante permissão de execução pro Maven wrapper
COPY . /work/
RUN chmod +x mvnw && ./mvnw clean package -DskipTests

# Etapa de execução
FROM eclipse-temurin:17-jre
WORKDIR /app/
COPY --from=build /work/target/*-runner.jar /app/app.jar

# Railway usará a porta definida por $PORT, então use variável de ambiente
ENV PORT=8080
EXPOSE ${PORT}

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
