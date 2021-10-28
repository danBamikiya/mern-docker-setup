FROM node:14-slim

WORKDIR /app

COPY  ["./package*.json", "./"]

RUN npm i

COPY [".", "."]

ENV NODE_ENV development

EXPOSE 3000

CMD [ "npm", "start" ]