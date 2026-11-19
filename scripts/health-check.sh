#!/usr/bin/env bash
set -euo pipefail

base_url="${1:?Usage: health-check.sh <base-url>}"
curl --fail --silent --show-error --max-time 10 \
  "${base_url%/}/api/v1/health"
printf '\n'