#FROM node:latest as builder
#RUN mkdir -p /app
#WORKDIR /app
#COPY package*.json /app/
#RUN npm install
#COPY . /app/
#EXPOSE 4200
#CMD ["npm", "run", "start"]


FROM node:12.16.1-alpine As builder
RUN mkdir -p /app
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build --prod

FROM nginx:1.15.8-alpine
EXPOSE 80
EXPOSE 4200
COPY --from=builder /app/dist/angular-test-app/ /usr/share/nginx/html
