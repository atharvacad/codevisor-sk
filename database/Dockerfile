# Use the official MongoDB image
FROM mongo:latest

# Set the working directory inside the container
WORKDIR /data

# Copy the JSON data file into the container
COPY projects.json /data/projects.json

# Copy the initialization script
COPY init.js /docker-entrypoint-initdb.d/init.js

# Copy the custom entrypoint script
COPY mongo-init.sh /docker-entrypoint-initdb.d/mongo-init.sh

# Expose MongoDB port
EXPOSE 27017