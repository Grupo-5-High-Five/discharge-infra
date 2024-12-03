#!/bin/sh

# Credenciais da AWS
read -p "Insira o AWS_ACCESS_KEY_ID: " AWS_ACCESS_KEY_ID
while [ -z "$AWS_ACCESS_KEY_ID" ]; do
    echo "AWS_ACCESS_KEY_ID não pode ser vazio. Por favor, insira novamente."
    read -p "Insira o AWS_ACCESS_KEY_ID: " AWS_ACCESS_KEY_ID
done

read -p "Insira o AWS_SECRET_ACCESS_KEY: " AWS_SECRET_ACCESS_KEY
while [ -z "$AWS_SECRET_ACCESS_KEY" ]; do
    echo "AWS_SECRET_ACCESS_KEY não pode ser vazio. Por favor, insira novamente."
    read -p "Insira o AWS_SECRET_ACCESS_KEY: " AWS_SECRET_ACCESS_KEY
done

read -p "Insira o AWS_SESSION_TOKEN: " AWS_SESSION_TOKEN
while [ -z "$AWS_SESSION_TOKEN" ]; do
    echo "AWS_SESSION_TOKEN não pode ser vazio. Por favor, insira novamente."
    read -p "Insira o AWS_SESSION_TOKEN: " AWS_SESSION_TOKEN
done

read -p "Insira o TOKEN (SLACK): " TOKEN
while [ -z "$TOKEN" ]; do
    echo "TOKEN não pode ser vazio. Por favor, insira novamente."
    read -p "Insira o TOKEN (SLACK): " TOKEN
done

sudo apt update && sudo apt upgrade -y

mkdir -p app
cd app
git clone https://github.com/Grupo-5-High-Five/discharge-infra.git
cd discharge-infra/

cat <<EOF > .env
AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN}
TOKEN=${TOKEN}
EOF

# Instale o Docker e o Docker Compose
sudo apt install docker.io -y
sudo apt install unzip curl -y
sudo apt install docker-compose -y

# Instale o AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Inicie os containers com o Docker Compose
sudo docker-compose up -d

# Liste os containers em execução
sudo docker ps -a

# Limpe as entradas do crontab
crontab -r

# Configure o cron para rodar o container e enviar logs para o S3
CRON="* * * * * sudo docker start java_container && sudo docker wait java_container && sudo docker logs java_container > /tmp/logs.txt && aws s3 cp /tmp/logs.txt s3://discharge-bucket/log_$(date +\%d-\%m-\%Y_\%H:\%M).log && rm /tmp/logs.txt && sudo truncate -s 0 /var/lib/docker/containers/$(docker inspect --format='{{.Id}}' java_container)/$(docker inspect --format='{{.Id}}' java_container)-json.log"

# Adicione a nova entrada ao crontab
echo "$CRON" | crontab -
echo "Crontab limpo e nova entrada adicionada: $CRON"
