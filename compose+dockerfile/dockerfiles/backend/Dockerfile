FROM openjdk:17-alpine

WORKDIR /app

RUN apk add --no-cache git \
    && git clone https://github.com/Grupo-5-High-Five/Backend.git . \
    && rm -rf .git 

EXPOSE 5555

CMD ["java", "-jar", "target/conexao-banco-de-dados-1.0-SNAPSHOT-jar-with-dependencies.jar"]

