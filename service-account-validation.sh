#!/bin/bash
echo "🔍 Grading your RBAC implementation..."

# 1. Check ServiceAccount
if kubectl get sa dev-sa -n meta &>/dev/null; then
    echo "  ✅ Success: ServiceAccount 'dev-sa' exists."
else
    echo "  ❌ Fail: ServiceAccount 'dev-sa' missing."
fi

# 2. Check Role permissions
VERBS=$(kubectl get role dev-deploy-role -n meta -o jsonpath='{.rules[0].verbs}' 2>/dev/null)
if [[ "$VERBS" == *"get"* && "$VERBS" == *"list"* && "$VERBS" == *"watch"* ]]; then
    echo "  ✅ Success: Role 'dev-deploy-role' has correct verbs."
else
    echo "  ❌ Fail: Role permissions are incorrect or missing."
fi

# 3. Check RoleBinding association
BINDING_SA=$(kubectl get rolebinding dev-deploy-rb -n meta -o jsonpath='{.subjects[0].name}' 2>/dev/null)
if [ "$BINDING_SA" == "dev-sa" ]; then
    echo "  ✅ Success: RoleBinding 'dev-deploy-rb' targets 'dev-sa'."
else
    echo "  ❌ Fail: RoleBinding missing or configured incorrectly."
fi

# 4. Check Auth Check (Can the service account list deployments?)
AUTH_CHECK=$(kubectl auth can-i list deployments --as=system:serviceaccount:meta:dev-sa -n meta)
if [ "$AUTH_CHECK" == "yes" ]; then
    echo "  ✅ Success: ServiceAccount can successfully list deployments."
else
    echo "  ❌ Fail: ServiceAccount still unauthorized."
fi

# 5. Check Deployment assignment
DEPLOY_SA=$(kubectl get deployment dev-deployment -n meta -o jsonpath='{.spec.template.spec.serviceAccountName}' 2>/dev/null)
if [ "$DEPLOY_SA" == "dev-sa" ]; then
    echo "  ✅ Success: 'dev-deployment' pods are now using 'dev-sa'."
else
    echo "  ❌ Fail: Deployment template is not using the new service account."
fi
