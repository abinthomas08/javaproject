# ===========================
# 1. BUILD STAGE
# ===========================
FROM maven:3.9.6-amazoncorretto-17 AS build

WORKDIR /app

# Copy everything
COPY . .

# Compile and package
RUN mvn -DskipTests=false package

# ===========================
# 2. RUN STAGE
# ===========================
FROM amazoncorretto:17-alpine

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
