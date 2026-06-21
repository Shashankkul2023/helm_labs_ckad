#!/bin/bash
echo "🧹 Wiping the playground..."

kubectl delete namespace meta --ignore-not-found=true

echo "✨ Environment cleaned!"
