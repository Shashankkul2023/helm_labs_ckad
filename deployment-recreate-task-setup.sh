#!/bin/bash
set -e

echo "🚀 Setting up the Kubernetes deployment task..."

# Create a temporary manifest file
cat <<EOF > target-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: challenge-deploy
  labels:
    app: challenge
spec:
  replicas: 2
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
  selector:
    matchLabels:
      app: challenge
  template:
    metadata:
      labels:
        app: challenge
    spec:
      containers:
      - name: nginx
        image: nginx:1.25-alpine
EOF

# Apply the deployment to the cluster
kubectl apply -f target-deployment.yaml

# Clean up local file
rm target-deployment.yaml

echo "⌛ Waiting for deployment to become ready..."
kubectl rollout status deployment/challenge-deploy --timeout=60s

echo "✅ Setup complete! Tell the candidate to change deployment/challenge-deploy strategy to Recreate."
