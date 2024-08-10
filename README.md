# docker-iam-db

This repository defines a MySQL Docker Image for a lite Identity Access Management Database (called iamDB).

# Part One: Set up the MySQL Docker container for iamDB database

Welcome to part 1 of my MicroService Tutorial!

## Step 1: Download and Install all pre-requisites
1. Docker: https://www.docker.com/products/docker-desktop/
2. mySQL Workbench: https://dev.mysql.com/downloads/workbench/
3. Github Desktop: https://github.com/apps/desktop

## Step 2: Clone this repository
1. Open Github Desktop
2. Clone this repo...

## Step 3: Review the Dockerfile for the MySQL Container
1. Navigate to the `docker-iam-db` directory
2. Open the `Dockerfile` file.
3. Review the content 

## Step 4: Review the SQL Initialization Script
1. Navigate the `docker-iam-db/db-ddl` directory
2. Open the SQL initialization script named `init.sql`. 
This script will be executed when the MySQL container starts and will initialize the IAM database schema and data.

## Step 5: Build the Docker Image
1. Open a terminal and navigate to the `docker-iam-db` directory.
2. Run the following command to build the Docker image: `docker build -t docker-iam-db .`
3. Check the created image: `docker image ls`
4. Note the IMAGE ID

## Step 7.1: Run the MySQL Container
1. Once the Docker image is built, run the MySQL container using the following command:
   `docker run -d --name docker-iam-db --env-file .env -p 3306:3306 docker-iam-db`

## Step 8: Verify the Container
1. Check the status of the running container using the following command: docker ps -a
2. You should see the `docker-iam-db` listed among the running containers.
3. Note the CONTAINER ID

## Step 9: Test the Sample Database
1. Enter the running docker: `docker exec -it <CONTAINER ID> /bin/bash`
   (Replace <CONTAINER ID> by actual container id value)
2. Login to mysql: `mysql -u admin -p`
3. Enter the password (see the .env file)  
4. Enter the following commands:
   `show databases;`
   `use iamDB;`
   `show tables;`
5. exit
6. exit

## Step 10: Clean-up!
1. Kill your running docker: `docker kill <CONTAINER ID>`
2. Remove the container: `docker rm <CONTAINER ID>`
3. Remove the image: `docker rmi <IMAGE ID>`

# Part Two: Create a docker network and run docker-iam-db container in this network

This section is applicable to the part 2 of my MicroService Tutorial.

## Step 6: Create a Network
This fourth step is not required at this time but is needed for the part 2 of this tutorial.
1. Open a terminal and execute the following command: `docker network create iam-service-network`
2. Check the created network: `docker network ls`
3. Note the NETWORK ID

## Step 7.2: Run the MySQL Container
This step replaces step 7.1
1. Run the MySQL container using the following command:
   `docker run -d --name docker-iam-db --network iam-service-network --env-file .env -p 3306:3306 docker-iam-db`

## Step 8: Verify the Container
See above.

## Step 9: Test the Sample Database
See above.

## Step 10.2: Clean-up!
1. Perform the steps described in Step 10
2.  Remove the docker network: docker network rm  <NETWORK ID>

# Contact Information
For more insights, subscribe to my Youtube Channel: https://www.youtube.com/user/jgreboul 
Thank you,
Jean-Gael Reboul
jgreboul@gmail.com



