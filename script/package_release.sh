#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEVELOPER_DIR="${DEVELOPER_DIR:-/Applications/Xcode.app/Contents/Developer}"
DERIVED_DATA_PATH="$ROOT_DIR/build/DerivedData"
APP_PATH="$DERIVED_DATA_PATH/Build/Products/Release/turnintoserver.app"
DIST_DIR="$ROOT_DIR/dist"
ZIP_PATH="$DIST_DIR/turnintoserver-1.2.1-menu-bar-crash-fix.zip"

DEVELOPER_DIR="$DEVELOPER_DIR" xcodebuild \
  -project "$ROOT_DIR/turnintoserver.xcodeproj" \
  -scheme turnintoserver \
  -configuration Release \
  -derivedDataPath "$DERIVED_DATA_PATH" \
  build

mkdir -p "$DIST_DIR"
rm -f "$ZIP_PATH"
/usr/bin/ditto -c -k --sequesterRsrc --keepParent "$APP_PATH" "$ZIP_PATH"
echo "$ZIP_PATH"
