FROM openjdk:23-jdk

RUN apt-get update -y && apt-get upgrade -y

WORKDIR /app

RUN git clone https://github.com/Grupo-5-High-Five/Backend.git .

RUN ./mvnw package

CMD ["java", "-jar", "target/conexao-banco-de-dados-1.0-SNAPSHOT-jar-with-dependencies.jar"]

