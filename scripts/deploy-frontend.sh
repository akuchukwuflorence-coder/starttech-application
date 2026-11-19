#!/usr/bin/env bash
set -euo pipefail

bucket="${1:?Usage: deploy-frontend.sh <bucket-name> <distribution-id>}"
distribution_id="${2:?Usage: deploy-frontend.sh <bucket-name> <distribution-id>}"
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
build_dir="$repo_root/frontend/dist"

if [[ ! -f "$build_dir/index.html" ]]; then
  echo "Missing frontend/dist/index.html. Build the frontend first." >&2
  exit 1
fi

aws s3 sync "$build_dir/" "s3://$bucket/" --delete
aws cloudfront create-invalidation \
  --distribution-id "$distribution_id" \
  --paths '/*'
