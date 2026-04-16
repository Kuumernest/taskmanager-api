#!/bin/bash

echo "Checking Git installation..."
if ! command -v git &> /dev/null
then
    echo "Git not found. Installing..."
    sudo apt update && sudo apt install git -y
else
    echo "Git is already installed."
fi

echo "Checking Docker installation..."
if ! command -v docker &> /dev/null
then
    echo "Docker not found. Installing..."
    sudo apt update && sudo apt install docker.io -y
else
    echo "Docker is already installed."
fi

echo "Starting Docker service..."
sudo systemctl start docker
sudo systemctl enable docker

REPO_URL="https://github.com/kuumernest/taskmanager-api.git"

cd ~
rm -rf taskmanager-api

echo "Cloning repository..."
git clone $REPO_URL
cd taskmanager-api || exit

echo "Checking required files..."
for file in package.json Dockerfile docker-compose.yml
do
    if [ ! -f "$file" ]; then
        echo "ERROR: Missing $file"
        exit 1
    fi
done

echo "Building and starting application..."
docker compose up --build -d

echo "SUCCESS!"
echo "Application is running at: http://localhost:5500"
