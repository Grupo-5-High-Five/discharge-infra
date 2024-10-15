FROM node:20.18.0

RUN apt-get update -y && apt-get upgrade -y

WORKDIR /app

RUN git clone https://github.com/Grupo-5-High-Five/projeto-discharge.git .

RUN npm install

CMD ["npm", "start"]