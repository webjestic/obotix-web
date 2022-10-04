# FROM node:16.15.1-alpine3.15
# WORKDIR /app
# RUN npm install -g http-server
# COPY package*.json ./
# RUN npm install
# COPY . ./
# RUN npm run build
# EXPOSE 8080
# RUN addgroup app && adduser -S -G app app
# USER app
# CMD ["http-server", "dist"]

# stage as builder
FROM node:10-alpine as builder
WORKDIR /vue-ui
COPY package*.json ./
RUN npm install
COPY . ./
RUN npm run build

# stage as production server
FROM nginx:alpine as production-build
COPY ./.nginx/nginx.conf /etc/nginx/nginx.conf
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /vue-ui/dist /usr/share/nginx/html
RUN addgroup app && adduser -S -G app app
USER app
EXPOSE 8080
ENTRYPOINT ["nginx", "-g", "daemon off;"]