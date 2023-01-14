FROM maven:3.8.5-openjdk-17 as build
# Install Maven
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

# Copy source code
FROM maven:3.8.5-openjdk-17
COPY --from=build /home/app/target/discovery-service-0.0.1.jar /usr/local/lib/discovery-service.jar
EXPOSE 8083
ENTRYPOINT ["java","-jar","/usr/local/lib/discovery-service.jar"]