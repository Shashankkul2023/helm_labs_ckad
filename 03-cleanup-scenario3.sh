#!/bin/bash
NAMESPACE="cd-tool-apd"
RELEASE_NAME="kubernetes-dashboard"

echo "🧹 Cleaning up Scenario 3..."
helm uninstall $RELEASE_NAME -n $NAMESPACE || true
kubectl delete namespace $NAMESPACE --wait=false || true
helm repo remove headlamp || true
