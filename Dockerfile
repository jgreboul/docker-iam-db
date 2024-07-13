# Use the official MySQL Docker image as the base image
FROM mysql:latest

# Copy SQL initialization scripts into the container
COPY ./db-ddl/init.sql /docker-entrypoint-initdb.d/

# Expose MySQL port
EXPOSE 3306
