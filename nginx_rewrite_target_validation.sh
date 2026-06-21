#!/bin/bash
echo "🔍 Validating Ingress configuration..."

# 1. Structural Check: Ensure the Ingress exists with the correct name
if ! kubectl get ingress ingress-vh-routing &> /dev/null; then
    echo "❌ Fail: Ingress resource named 'ingress-vh-routing' not found."
    exit 1
fi

# 2. Annotation Check: Verify the rewrite target is exact
REWRITE_VAL=$(kubectl get ingress ingress-vh-routing -o jsonpath='{.metadata.annotations.nginx\.ingress\.kubernetes\.io/rewrite-target}')
if [ "$REWRITE_VAL" != "/" ]; then
    echo "❌ Fail: Incorrect or missing rewrite-target annotation. Expected '/' but found '$REWRITE_VAL'."
    exit 1
fi

# 3. Traffic Routing Check: Simulate real traffic utilizing Host headers
# Grab local Ingress Controller ClusterIP or NodePort (Defaulting to standard internal mapping)
INGRESS_IP=$(kubectl get svc -n ingress-nginx ingress-nginx-controller -o jsonpath='{.spec.clusterIP}' 2>/dev/null || echo "127.0.0.1")

echo "🌐 Testing Video Domain Routing..."
VIDEO_RESP=$(curl -s -H "Host: watch.ecom-store.com" http://$INGRESS_IP/video)
if [[ "$VIDEO_RESP" == *"Video Streaming"* ]]; then
    echo "  ✅ Success: watch.ecom-store.com/video routed correctly."
else
    echo "  ❌ Fail: watch.ecom-store.com/video did not return the expected video backend response."
fi

echo "🌐 Testing Apparels Domain Routing..."
APPARELS_RESP=$(curl -s -H "Host: apparels.ecom-store.com" http://$INGRESS_IP/wear)
if [[ "$APPARELS_RESP" == *"Apparels Fashion"* ]]; then
    echo "  ✅ Success: apparels.ecom-store.com/wear routed correctly."
else
    echo "  ❌ Fail: apparels.ecom-store.com/wear did not return the expected apparels backend response."
fi
