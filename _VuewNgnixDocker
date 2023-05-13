# FROM nginx:alpine
# WORKDIR /app
# RUN apk add --update nodejs npm
# COPY package*.json ./
# RUN npm install
# COPY . ./
# RUN npm run build
# COPY nginx.conf /etc/nginx/nginx.conf
# RUN rm -rf /usr/share/nginx/html/*
# RUN cp -rf dist/* /usr/share/nginx/html/
# RUN rm -rf /app/*
# EXPOSE 8080
# ENTRYPOINT ["nginx", "-g", "daemon off;"]

# stage as builder
FROM node:16.15.1-alpine3.15 as builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . ./
RUN npm run build

# stage as production server
FROM nginx:alpine as production-build
COPY nginx.conf /etc/nginx/nginx.conf
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 8080
ENTRYPOINT ["nginx", "-g", "daemon off;"]
