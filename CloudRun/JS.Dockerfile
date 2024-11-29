# Use an official Node.js image as the base
FROM node:18

# Set the working directory to /app
WORKDIR /app

# Copy the package*.json files to the working directory
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the application code to the working directory
COPY . .

# Set the environment variables
ENV port=8080

# Expose the port the application will run on
EXPOSE 8080

# Run the command to start the server in production mode
CMD ["node", "src/server/server.js"]