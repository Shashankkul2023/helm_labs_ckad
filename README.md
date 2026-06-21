# CKAD Helm Practice Lab Guide

This repository contains automated environment setup, validation, and cleanup scripts designed to help you practice real-world Helm scenarios encountered in the **Certified Kubernetes Application Developer (CKAD)** exam.

---

## 📋 Scenarios Overview

### Scenario 1: Upgrade & Scale an Existing Release (`cluster3`)
* **Task:** A coworker deployed an Nginx Helm chart named `lvm-crystal-apd`. An update is pushed. You must update the repository, pull the latest changes, upgrade the chart version explicitly to `18.1.15`, and scale the replica count up to `2`.
* **Environment:** Executed targeting the `crystal-apd-ns` namespace.

### Scenario 2: Validate & Replace/Upgrade a Local Chart
* **Task:** An application (`webpage-server-01`) is running in the `default` namespace. A new version of the chart is provided in the local directory `/root/new-version`. You must lint/validate the chart for syntax errors, then update the deployment to use this new local definition.

### Scenario 3: Remote Target Deployment (`cluster1`)
* **Task:** The team lead requires deploying Headlamp to handle management dashboards. You must add the remote signature chart repository `headlamp`, configure the release explicitly as `kubernetes-dashboard`, and target the `cd-tool-apd` namespace.

---

## 🛠️ Script Workflow

Each scenario contains a set of three distinct scripts that must be run in sequence:

1. **`01-setup-scenarioX.sh`**: Prepares the target namespaces, populates mock baseline applications, and mocks configurations so you have an active environment to fix.
2. **`02-validate-scenarioX.sh`**: The grading engine. Run this *after* you attempt the solution to verify if your configurations meet the specific exam parameters.
3. **`03-cleanup-scenarioX.sh`**: Housekeeping script. Wipes out the namespaces, test releases, and temporary test directories to return your cluster to a pristine state.

---

## 🚀 How to Run the Lab

### Step 1: Make all scripts executable
Before executing any script, ensure your environment grants execution permissions to the files:
```bash
chmod +x *-scenario*.sh
