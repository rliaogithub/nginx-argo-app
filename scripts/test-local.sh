#!/bin/bash

# Local testing script for nginx-argo-app

set -e

echo "🚀 Building Docker image..."
docker build -t nginx-argo-app:local .

echo "🔄 Starting container..."
docker run -d -p 8080:80 --name nginx-argo-local nginx-argo-app:local

echo "⏳ Waiting for container to start..."
sleep 3

echo "🧪 Testing application..."
if curl -s http://localhost:8080 | grep -q "Nginx Argo App"; then
    echo "✅ Application is running successfully!"
    echo "🌐 Visit: http://localhost:8080"
else
    echo "❌ Application test failed!"
    exit 1
fi

echo ""
echo "To stop the container, run:"
echo "  docker stop nginx-argo-local && docker rm nginx-argo-local"