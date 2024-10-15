FROM openjdk:17
WORKDIR /app
RUN git clone https://github.com/Grupo-5-High-Five/Backend.git .
RUN ./mvnw package
CMD ["java", "-jar", "target/myapp.jar"]
