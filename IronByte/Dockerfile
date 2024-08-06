# Stage 1: Compile and Build Angular codebase

# Use official Node.js image as the base image
FROM node:latest as build

# Set the working directory
WORKDIR /usr/local/app

# Add the source code to app
COPY ./ /usr/local/app/

# Install all the dependencies
RUN npm install

# Generate the build of the application
RUN npm run build

# Stage 2: Serve app with Nginx server

# Use official Nginx image as the base image
FROM nginx:latest

# Copy the build output to replace the default Nginx contents
COPY --from=build /usr/local/app/dist/sample-angular-app /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
