# Discharge-docker

## Índice

1. [Descrição do Projeto](#descrição-do-projeto)
2. [Tecnologias Utilizadas](#tecnologias-utilizadas)
3. [Estrutura do Repositório](#estrutura-do-repositório)
4. [Configuração do Docker Compose](#configuração-do-docker-compose)
5. [Configuração do CloudFormation](#configuração-do-cloudformation)

## Descrição do Projeto

Este repositório contém as configurações para implantar a infraestrutura utilizando Docker Compose, AWS CloudFormation e um esquema SQL inicial.

## Tecnologias Utilizadas

- [Docker](https://www.docker.com/)
- [AWS CloudFormation](https://aws.amazon.com/cloudformation/)
- [MySQL](https://www.mysql.com/)

## Estrutura do Repositório

```
├── docker-compose.yml
├── main.yaml
└── init.sql
```

## Configuração do Docker Compose

O Docker compose está sendo utilizado para criação de 3 containers

mysql_container 

Criando o banco de dados a partir do arquivo init.sql(que contém o esquema do banco de dados MySQL) e o usuário que realiza as manipulações dentro do banco de dados

```
  db:
    image: mysql:8.0
    container_name: mysql_container
    environment:
      MYSQL_ROOT_PASSWORD: 123
      MYSQL_DATABASE: discharge
      MYSQL_USER: db_user
      MYSQL_PASSWORD: 123
    ports:
      - "3306:3306"
    volumes:
      - db_data:/var/lib/mysql
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql
```

java_container

Realiza a execução da aplicação em Java, utilizando o usuário do banco de dados criado pelo mysql_container - Acessando a AWS para leitura de arquivos dentro do S3 e às inserindo no banco de dados

```
    backend:
    image: eclipse-temurin:21-jdk-alpine
    container_name: java_container
    environment:
      # Acesso ao Container DB
      DB_URL: jdbc:mysql://db/discharge
      DB_USER: db_user
      DB_PASSWORD: 123
      # Acesso ao S3
      AWS_ACCESS_KEY_ID:
      AWS_SECRET_ACCESS_KEY:
      AWS_SESSION_TOKEN:
    working_dir: /app
    command: >
      /bin/sh -c "
      apk add --no-cache git &&
      if [ ! -d .git ]; then git clone https://github.com/Grupo-5-High-Five/discharge-backend.git .; fi &&
      until java -jar target/discharge-1.0-SNAPSHOT-jar-with-dependencies.jar; do sleep 5; done"
    ports:
      - "5555:5555"
    depends_on:
      - db
```

node_container

Roda a aplicação Web com o NodeJS e visualiza informações vindas do banco de dados

```
frontend:
    image: node:20.18.0-alpine
    container_name: node_container
    environment:
      AMBIENTE_PROCESSO: 
      DB_HOST: db
      DB_DATABASE: discharge
      DB_USER: db_user
      DB_PASSWORD: 123
      DB_PORT: 3306
      APP_PORT: 3333
      APP_HOST: localhost
    working_dir: /app
    command: >
      /bin/sh -c "
      apk add --no-cache git &&
      if [ ! -d .git ]; then git clone https://github.com/Grupo-5-High-Five/discharge-web.git .; fi &&
      npm install &&
      npm start"
    ports:
      - "3333:3333"
    depends_on:
      - db
```

## Configuração do CloudFormation

No arquivo main.yaml é possível visualizar as configurações necessárias para que o projeto seja executado na AWS. Dessa forma, é automatizado a criação da EC2 e suas demais configurações.
*Necessário apenas a criação de uma pilha(stack)

EC2 (Definições de Hardware e Acesso)

Grupos de Segurança (Liberação de portas do projeto)

VPC (Com as demais configurações para o seu acesso)