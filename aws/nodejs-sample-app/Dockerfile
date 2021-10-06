FROM node:15.6.0-alpine3.11 
WORKDIR /app
COPY nodejs/package*.json /app/
RUN npm install
COPY nodejs/server.js .
EXPOSE 3000
CMD [ "node", "server.js" ]