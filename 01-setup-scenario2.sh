#!/bin/bash
set -e
echo "⚙️  Setting up Scenario 2..."

# 1. Deploy the initial old version application
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install webpage-server-01 bitnami/nginx -n default --version 18.1.0

# 2. Mock the local chart folder in /root/new-version
mkdir -p /root/new-version
helm create /root/new-version-tmp
mv /root/new-version-tmp/* /root/new-version/
rm -rf /root/new-version-tmp

# Modify version in Chart.yaml to stand out as the 'new' version
sed -i 's/version: 0.1.0/version: 2.0.0/g' /root/new-version/Chart.yaml

echo "🚀 Setup complete. A mock chart folder exists at /root/new-version."
echo "Go ahead and lint, then run either the generation/install method or the 'helm upgrade' strategy."
