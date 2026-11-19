#!/usr/bin/env bash
set -euo pipefail

image="${1:?Usage: deploy-backend.sh <ecr-image-with-tag> <context> [namespace]}"
context="${2:?Usage: deploy-backend.sh <ecr-image-with-tag> <context> [namespace]}"
namespace="${3:-default}"
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
kube=(kubectl --context "$context" --namespace "$namespace")

deployment_yaml="$(
  kubectl set image --local -f "$repo_root/k8s/deployment.yaml" \
    "backend-api=$image" -o yaml
)"

printf '%s\n' "$deployment_yaml" | "${kube[@]}" apply -f -
"${kube[@]}" apply -f "$repo_root/k8s/service.yaml" -f "$repo_root/k8s/ingress.yaml"
"${kube[@]}" rollout status deployment/backend-api --timeout=300s