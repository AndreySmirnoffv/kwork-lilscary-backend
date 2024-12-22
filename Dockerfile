FROM node:23-alpine AS build

WORKDIR /app
COPY package.json package.json
RUN npm install

COPY . . 
RUN npm run build

FROM nginx:stable-alpine

WORKDIR /usr/share/nginx/html
COPY --from=build /app/dist .

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
