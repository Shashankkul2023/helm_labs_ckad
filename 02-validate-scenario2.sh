#!/bin/bash
echo "🔍 Validating Scenario 2..."

# Check if the upgrade was successfully registered
CURRENT_VERSION=$(helm list -n default -o json | grep -o '"chart":"[^"]*' | grep -o '[^"]*$')

if [[ "$CURRENT_VERSION" == *"2.0.0"* ]]; then
    echo "✓ PASSED: New chart version (2.0.0) successfully deployed!"
else
    echo "❌ FAILED: The old or unintended version is still running: $CURRENT_VERSION"
fi
