# Étape 1 : Build
FROM eclipse-temurin:21-jdk-alpine AS build

# Definir le repertoire de travail
WORKDIR /app

# Installer Maven
RUN apk add --no-cache maven

# Copier les fichiers du projet
COPY . .

# Builder l'application
RUN mvn clean package -DskipTests

# Étape 2 : Runtime
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# Copier le JAR depuis l'etape de build
COPY --from=build /app/target/*.jar app.jar

# Exposer le port sur lequel l'application ecoute
EXPOSE 8080

# Commande pour demarrer l'application
ENTRYPOINT ["java", "-jar", "app.jar"]