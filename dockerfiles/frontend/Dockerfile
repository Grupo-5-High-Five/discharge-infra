# Imagem base Node.js versão 20.18.0
FROM node:20.18.0-alpine

WORKDIR /app

RUN apk add --no-cache git \
    && git clone https://github.com/Grupo-5-High-Five/projeto-discharge.git . \
    && rm -rf .git

RUN npm install

EXPOSE 3333

CMD ["npm", "start"]
