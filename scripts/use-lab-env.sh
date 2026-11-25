#!/usr/bin/env bash
set -euo pipefail

LAB_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
export AWS_CONFIG_FILE="$LAB_ROOT/.secrets/config"
export AWS_SHARED_CREDENTIALS_FILE="$LAB_ROOT/.secrets/credentials"
export AWS_LOGIN_CACHE_DIRECTORY="$LAB_ROOT/.secrets/login-cache"
export AWS_PAGER=""

unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_PROFILE \
  AWS_DEFAULT_PROFILE AWS_REGION AWS_DEFAULT_REGION

umask 077
mkdir -p "$LAB_ROOT/.secrets/login-cache"
chmod 700 "$LAB_ROOT/.secrets"

echo "Lab AWS environment isolated under $LAB_ROOT/.secrets"

