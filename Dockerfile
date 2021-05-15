FROM node:12.16.1-alpine As builder
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build --prod

FROM nginx:1.15.8-alpine
EXPOSE 80
EXPOSE 4200
COPY --from=builder /usr/src/app/dist/SampleApp/ /usr/share/nginx/html
