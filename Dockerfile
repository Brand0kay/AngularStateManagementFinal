FROM node:16.13 as build
WORKDIR /dist/src/app
RUN npm cache clean --force
COPY package*.json ./
RUN npm install -g npm@8.4.1
RUN npm install
COPY . .
RUN npm run build
FROM nginx:1.21.6 AS ngi
COPY --from=build /dist/src/app/dist/angularstatemanagement /usr/share/nginx/html
COPY /nginx.conf  /etc/nginx/conf.d/default.conf
EXPOSE 80
