#!/bin/bash
echo "🧹 Cleaning up playground resources..."

# Remove the ingress rule
kubectl delete ingress ingress-vh-routing --ignore-not-found=true

# Remove backend services
kubectl delete svc video-service apparels-service --ignore-not-found=true

# Remove backend deployments
kubectl delete deployment video-service apparels-service --ignore-not-found=true

echo "✨ Environment cleaned up successfully!"
