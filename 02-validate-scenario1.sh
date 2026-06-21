#!/bin/bash
NAMESPACE="crystal-apd-ns"
RELEASE_NAME="lvm-crystal-apd"

echo "🔍 Validating Scenario 1..."

# 1. Check Helm version
CHART_VER=$(helm list -n $NAMESPACE -o json | grep -o '"chart":"[^"]*' | grep -o '[^"]*$')
if [[ "$CHART_VER" == *"18.1.15"* ]]; then
    echo "✓ PASSED: Chart version is 18.1.15."
else
    echo "❌ FAILED: Chart version is '$CHART_VER', expected 18.1.15."
fi

# 2. Check Deployment Replicas
REPLICAS=$(kubectl get deploy -n $NAMESPACE -o jsonpath='{.items[0].spec.replicas}' 2>/dev/null)
if [ "$REPLICAS" -eq 2 ]; then
    echo "✓ PASSED: Replica count is scaled to 2."
else
    echo "❌ FAILED: Replicas set to '$REPLICAS', expected 2."
fi
