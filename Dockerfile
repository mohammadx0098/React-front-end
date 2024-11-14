# # Stage 1: Build the React application
# FROM node:16-alpine AS build

# # Set the working directory inside the container
# WORKDIR /app

# # Copy package.json and package-lock.json to install dependencies
# COPY package*.json ./

# # Install dependencies
# RUN npm install

# # Copy the entire project source code to the container
# COPY . .

# # Build the React app for production
# RUN npm run build

# # Stage 2: Serve the application using Nginx
# FROM nginx:alpine

# # Copy the built files from the previous stage to Nginx's default serving directory
# COPY --from=build /app/build /usr/share/nginx/html

# # Expose port 80 for the web server
# EXPOSE 80

# # Start Nginx in the foreground
# CMD ["nginx", "-g", "daemon off;"]

# # EXPOSE 3000
# # CMD ["npm", "start"]

# Use Node.js for both building and serving the app
FROM node:16-alpine AS build

WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the source code and build the React app
COPY . .
RUN npm run build

# Use a lightweight Node.js server for serving the build files
RUN npm install -g serve

# Expose the port used by the 'serve' package
EXPOSE 3000

# Start the app with 'serve'
CMD ["serve", "-s", "build", "-l", "3000"]
