FROM node:20-alpine3.22

RUN apk add --no-cache curl

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY server.js ./
COPY public ./public

EXPOSE 3000

CMD ["npm", "start"]
