#!/bin/sh

AWS_ACCESS_KEY_ID=""
AWS_SECRET_ACCESS_KEY="" 
AWS_SESSION_TOKEN=""
sudo apt update && sudo apt upgrade -y

mkdir -p app
cd app

git clone https://github.com/Grupo-5-High-Five/discharge-infra.git

cd discharge-infra/

cat <<EOF > .env
AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN}
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

# Configure o cron para rodar o container e enviar logs para o S3
CRON="* * * * * sudo docker start java_container && sudo docker logs java_container > /tmp/logs.txt && aws s3 cp /tmp/logs.txt s3://discharge-bucket/log_$(date +'%Y-%m-%d_%H-%M-%S').log && rm /tmp/logs.txt"

# Adicione a entrada ao crontab, se não existir
if crontab -l | grep -Fxq "$CRON"; then
    echo "Crontab já existe."
else
    (crontab -l; echo "$CRON") | crontab -
    echo "Crontab adicionado: $CRON"
fi