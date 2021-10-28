FROM node:14-slim

WORKDIR /app

COPY ["./package*.json", "./"]

RUN npm i

COPY [".", "."]

ENV NODE_ENV development

EXPOSE 4040

CMD [ "npm", "run", "dev" ]