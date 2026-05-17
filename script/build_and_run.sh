#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEVELOPER_DIR="${DEVELOPER_DIR:-/Applications/Xcode.app/Contents/Developer}"
DERIVED_DATA_PATH="$ROOT_DIR/build/DerivedData"
APP_PATH="$DERIVED_DATA_PATH/Build/Products/Release/turnintoserver.app"

if pgrep -x turnintoserver >/dev/null 2>&1; then
  pkill -x turnintoserver
  sleep 1
fi

DEVELOPER_DIR="$DEVELOPER_DIR" xcodebuild \
  -project "$ROOT_DIR/turnintoserver.xcodeproj" \
  -scheme turnintoserver \
  -configuration Release \
  -derivedDataPath "$DERIVED_DATA_PATH" \
  build

/usr/bin/open -n "$APP_PATH"

if [[ "${1:-}" == "--verify" ]]; then
  sleep 2
  pgrep -x turnintoserver >/dev/null
fi
