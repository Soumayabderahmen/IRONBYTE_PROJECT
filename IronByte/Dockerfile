#Download Node Alpine image
FROM node:alpine As build

#Setup the working directory
WORKDIR /usr/src/app

#Copy package.json
COPY package.json package-lock.json ./

#Install dependencies
RUN npm install

#Copy other files and folder to working directory
COPY . .

#Build Angular application in PROD mode
RUN npm run build --prod

#Download NGINX Image
FROM nginx:alpine
EXPOSE 80
# Copiez le fichier de configuration Nginx personnalisé
#COPY src/nginx/etc/conf.d/default.conf /etc/nginx/conf.d/default.conf
#Copy built angular app files to NGINX HTML folder
COPY --from=build /usr/src/app/dist/iron-byte/ /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
