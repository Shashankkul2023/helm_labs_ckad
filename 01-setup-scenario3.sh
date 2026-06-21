#!/bin/bash
set -e
NAMESPACE="cd-tool-apd"

echo "⚙️  Setting up Scenario 3..."
# Ensure destination namespace exists
kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -
echo "🚀 Setup complete. Execute your repo addition and targeted release install now."
