#!/bin/bash

echo "🔍 Validating candidate solution..."

# 1. Check if the deployment exists
if ! kubectl get deployment challenge-deploy &> /dev/null; then
    echo "❌ FAIL: Deployment 'challenge-deploy' does not exist."
    exit 1
fi

# 2. Extract and check the strategy type
STRATEGY_TYPE=$(kubectl get deployment challenge-deploy -o jsonpath='{.spec.strategy.type}')

if [ "$STRATEGY_TYPE" = "Recreate" ]; then
    echo "✅ SUCCESS: The deployment strategy type is correctly set to 'Recreate'."
    exit 0
else
    echo "❌ FAIL: Deployment strategy type is '$STRATEGY_TYPE', but expected 'Recreate'."
    exit 1
fi
