#!/bin/bash
NAMESPACE="cd-tool-apd"
RELEASE_NAME="kubernetes-dashboard"

echo "🔍 Validating Scenario 3..."

# 1. Verify specific Release Name inside specific namespace
if helm status $RELEASE_NAME -n $NAMESPACE &> /dev/null; then
    echo "✓ PASSED: Helm release '$RELEASE_NAME' found in namespace '$NAMESPACE'."
else
    echo "❌ FAILED: Release '$RELEASE_NAME' not found in namespace '$NAMESPACE'."
fi

# 2. Verify tracking chart origin matches headlamp
CHART_ORIGIN=$(helm list -n $NAMESPACE -o json | grep -o '"chart":"[^"]*' | grep -o '[^"]*$')
if [[ "$CHART_ORIGIN" == *"headlamp"* ]]; then
    echo "✓ PASSED: Chart used originates from Headlamp family."
else
    echo "❌ FAILED: Unexpected chart detected: $CHART_ORIGIN"
fi
