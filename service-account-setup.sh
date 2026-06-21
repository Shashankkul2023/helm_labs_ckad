#!/bin/bash
echo "🚀 Creating the broken scenario setup..."

# Create the namespace
kubectl create namespace meta --or-already-exists

# Create a dummy deployment that simulates a monitoring pod wanting to read deployments
kubectl create deployment dev-deployment -n meta --image=nginx:alpine --replicas=1

echo "✅ Setup complete! The deployment 'dev-deployment' is running in namespace 'meta' without permissions."
