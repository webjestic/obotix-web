FROM node:16.15.1-alpine3.15
WORKDIR /app
RUN npm install -g http-server
COPY package*.json ./
RUN npm install
COPY . ./
RUN npm run build
EXPOSE 8080
RUN addgroup app && adduser -S -G app app
USER app
CMD ["http-server", "dist"]