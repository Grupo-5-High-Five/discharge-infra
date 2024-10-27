#!/bin/sh

AWS_ACCESS_KEY_ID="ASIA3ANBUEYU3XT6CUKN"
AWS_SECRET_ACCESS_KEY="UcC+08v0C+FNXZsKKqcpxIVQzdyXcdatGHzlblLh" 
AWS_SESSION_TOKEN="IQoJb3JpZ2luX2VjEF0aCXVzLXdlc3QtMiJGMEQCIHk1vvWlu8yth6ZY6caXk0n18pQFZaE1BU4bCC8qD2wAAiBaalwytQ+D9cXpFsuebFTfxXFqCozEWGpF+Q6q6IK36yq/AgjG//////////8BEAEaDDc1Njc5MDA3Njk2OSIM5BB1KGvnJ0FfBh7HKpMCbzIhO5oKlHle6/WzaztT9lR8MWsoTVcOl4iu+i6bJb4AGWTjpoJAgOcXuDfR/S2UnRRuP3/b1aDTo51u1SktKplgEWALQroVYQR7bIOSKgoKrfADEGUE94lFfpmTTwAZK0/fvLDHah+Fjdw6Y8MV3fVTCoZ+2CIDAFblo36MphEbon6JjfHjtKQOJg6NWo/vsc4S4AWAHFWoR1R2jNrmMRtBRDtq6Cl++PIf6SqW4HnDse+sQfmxVBju1vE7VF/ZpQSmm4vOquKwqhLhxVgwIcU7pS7B4u5TMboFyeZIyLq8mobQD65a34TKl8edQWDq2ZcquxKVoQv27XascpMxPWD/KSAUlBpDkA1FFKJcx3ioGmcwvL7luAY6ngGVRZ+up7Kx8ecTXkCrc9xATljLTzCDUa4/ExNEAzxPGwPArnrd//DUagY56W+MyuOldK18Nt7YKZRTxugBw6xHQAYCxGf9sXJlqYzeZwFdoXByN+hS0ZER182Fg15/B2fKHDkPRBX9LtQEKWtHenvzvj83zYEzxjiS8vAkM0WqVCrJUp70Ik7/kH0UA7FjioMcoOFHKMeVwYYfzgqmkQ=="

sudo apt update && sudo apt upgrade -y

mkdir infra
cd infra/

git clone https://github.com/Grupo-5-High-Five/discharge-infra.git

cd discharge-infra/

cat <<EOF > .env
AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN}
EOF

sudo apt install docker.io -y
sudo apt install docker-compose -y
sudo docker-compose up -d

docker ps -a

(crontab -l; echo "* * * * * docker start java_container") | crontab -
