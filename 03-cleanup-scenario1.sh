#!/bin/bash
NAMESPACE="crystal-apd-ns"
RELEASE_NAME="lvm-crystal-apd"

echo "🧹 Cleaning up Scenario 1..."
helm uninstall $RELEASE_NAME -n $NAMESPACE || true
kubectl delete namespace $NAMESPACE --wait=false || true
