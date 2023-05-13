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
RUN npm run generate

# stage as production server
FROM nginx:alpine as production-build
COPY nginx.conf /etc/nginx/nginx.conf
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /app/dist/* /usr/share/nginx/html
EXPOSE 8080
ENTRYPOINT ["nginx", "-g", "daemon off;"]