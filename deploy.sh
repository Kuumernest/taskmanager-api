#!/bin/bash

echo "Checking Git..."
if ! command -v git &> /dev/null; then
    sudo apt update && sudo apt install git -y
fi

echo "Checking Docker..."
if ! command -v docker &> /dev/null; then
    sudo apt update && sudo apt install docker.io -y
fi

echo "Starting Docker..."
sudo systemctl start docker
sudo systemctl enable docker

REPO_URL="https://github.com/kuumernest/taskmanager-api.git"

cd ~
rm -rf taskmanager-api

git clone $REPO_URL
cd taskmanager-api || exit

echo "Checking required files..."
for file in package.json Dockerfile docker-compose.yml
do
    if [ ! -f "$file" ]; then
        echo "Missing $file"
        exit 1
    fi
done

docker compose up --build -d

echo "App running at: http://localhost:5500"
