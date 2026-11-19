#!/usr/bin/env bash
set -euo pipefail

context="${1:?Usage: rollback.sh <kubernetes-context> [namespace]}"
namespace="${2:-default}"

kubectl --context "$context" --namespace "$namespace" \
  rollout undo deployment/backend-api

kubectl --context "$context" --namespace "$namespace" \
  rollout status deployment/backend-api --timeout=180s