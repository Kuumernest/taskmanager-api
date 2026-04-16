#!/bin/bash

echo "Checking Git..."
if ! command -v git &> /dev/null
then
    echo "Install Git manually on Windows"
    exit 1
fi

echo "Checking Docker..."
if ! command -v docker &> /dev/null
then
    echo "Install Docker Desktop"
    exit 1
fi

REPO_URL="https://github.com/YOUR_USERNAME/taskmanager-api.git"

cd ~ || exit
rm -rf taskmanager-api

git clone $REPO_URL
cd taskmanager-api || exit

echo "Checking files..."
for file in package.json Dockerfile docker-compose.yml
do
    if [ ! -f "$file" ]; then
        echo "Missing $file"
        exit 1
    fi
done

docker compose up --build -d

echo "App running at http://localhost:5500"