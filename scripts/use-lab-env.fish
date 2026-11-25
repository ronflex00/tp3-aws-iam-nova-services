# Isolate AWS CLI configuration for this laboratory in the current project.
# Source this file from the tp-aws-iam directory.

set -gx AWS_CONFIG_FILE "$PWD/.secrets/config"
set -gx AWS_SHARED_CREDENTIALS_FILE "$PWD/.secrets/credentials"
set -gx AWS_LOGIN_CACHE_DIRECTORY "$PWD/.secrets/login-cache"
set -gx AWS_PAGER ""

set -e AWS_ACCESS_KEY_ID
set -e AWS_SECRET_ACCESS_KEY
set -e AWS_SESSION_TOKEN
set -e AWS_PROFILE
set -e AWS_DEFAULT_PROFILE
set -e AWS_REGION
set -e AWS_DEFAULT_REGION

umask 077
mkdir -p "$PWD/.secrets/login-cache"
chmod 700 "$PWD/.secrets"

echo "Lab AWS environment isolated under $PWD/.secrets"
