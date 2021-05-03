FROM node:16-alpine3.11

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install && npm install -g truffle@5.1.59

COPY . .

CMD ["truffle", "test"]