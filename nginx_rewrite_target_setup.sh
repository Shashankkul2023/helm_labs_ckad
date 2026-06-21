#!/bin/bash
echo "🚀 Setting up the multi-host Ingress playground..."

# 1. Create the backend deployments
kubectl create deployment video-service --image=nginx:alpine --port=80
kubectl create deployment apparels-service --image=nginx:alpine --port=80

# 2. Expose deployments as ClusterIP services on port 80
kubectl expose deployment video-service --port=80 --target-port=80
kubectl expose deployment apparels-service --port=80 --target-port=80

# 3. Create dummy content inside the pods to easily distinguish the responses
echo "⏳ Waiting for backend pods to be ready..."
kubectl wait --for=condition=ready pod -l app=video-service --timeout=60s
kubectl wait --for=condition=ready pod -l app=apparels-service --timeout=60s

VIDEO_POD=$(kubectl get pods -l app=video-service -o jsonpath='{.items[0].metadata.name}')
APPARELS_POD=$(kubectl get pods -l app=apparels-service -o jsonpath='{.items[0].metadata.name}')

kubectl exec $VIDEO_POD -- sh -c "echo '🎬 Welcome to the Video Streaming Service!' > /usr/share/nginx/html/index.html"
kubectl exec $APPARELS_POD -- sh -c "echo '👚 Welcome to the Apparels Fashion Store!' > /usr/share/nginx/html/index.html"

echo "✅ Setup complete! You can now create your Ingress resource named 'ingress-vh-routing'."
