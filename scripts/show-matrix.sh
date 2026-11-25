#!/usr/bin/env bash
set -euo pipefail

sed -n '1,200p' "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)/docs/tests.md"

