# FROM node:16.15.1-alpine3.15
# WORKDIR /app
# COPY package*.json ./
# RUN npm install
# RUN npm build
# COPY . ./
# EXPOSE 8080
# RUN addgroup app && adduser -S -G app app
# USER app
# CMD ["npm", "start"]

FROM node:16.15.1-alpine3.15 as builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . ./
RUN npm run build
EXPOSE 8080
RUN addgroup app && adduser -S -G app app
USER app
CMD ["npm", "start"]