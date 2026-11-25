#!/usr/bin/env bash
set -euo pipefail

echo "PWD: $(pwd)"
if command -v aws >/dev/null 2>&1; then
  aws --version
else
  echo "ERROR: AWS CLI is not installed." >&2
  exit 127
fi

git --version
python3 --version

