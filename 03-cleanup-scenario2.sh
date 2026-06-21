#!/bin/bash
echo "🧹 Cleaning up Scenario 2..."
# Handle cleaning both potential release names depending on user path strategy
helm uninstall webpage-server-01 -n default || true
helm list -n default -q | xargs -I {} helm uninstall {} -n default || true
rm -rf /root/new-version
