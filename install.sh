#!/bin/sh 

sudo apt update && sudo apt upgrade -y

mkdir infra
cd infra/

git clone https://github.com/Grupo-5-High-Five/discharge-infra.git

cd discharge-infra/

sudo apt install docker.io -y
sudo apt install docker-compose -y

sudo docker-compose up -d

# sudo docker-compose down -v && sudo docker-compose down --rmi all -v


