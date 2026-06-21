#!/bin/bash
# Run on cluster3-controlplane
set -e
NAMESPACE="crystal-apd-ns"
REPO_NAME="lvm-crystal-apd"
RELEASE_NAME="lvm-crystal-apd"

echo "⚙️  Setting up Scenario 1..."
kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

# Add bitnami as the mock repository source for nginx
helm repo add $REPO_NAME https://charts.bitnami.com/bitnami
helm repo update

# Install an older version (e.g., 18.1.14) with 1 replica to simulate pre-existing state
helm install $RELEASE_NAME $REPO_NAME/nginx \
  -n $NAMESPACE \
  --version 18.1.14 \
  --set replicaCount=1

echo "🚀 Setup complete. Now perform your upgrade to version 18.1.15 and scale replicas to 2!"
