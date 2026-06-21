#!/bin/bash
echo "🧹 Cleaning up task resources..."

# Delete the deployment if it exists
if kubectl get deployment challenge-deploy &> /dev/null; then
    kubectl delete deployment challenge-deploy
    echo "✅ Removed deployment 'challenge-deploy'."
else
    echo "ℹ️ Deployment 'challenge-deploy' already removed or did not exist."
fi

echo "✨ Cleanup complete!"
