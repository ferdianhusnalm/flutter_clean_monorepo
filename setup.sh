#!/usr/bin/env bash
# scripts/setup.sh — Run once after cloning to set up the mono-repo

set -e

CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log()  { echo -e "${CYAN}[setup]${NC} $1"; }
ok()   { echo -e "${GREEN}[✓]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }

log "Checking Flutter..."
if ! command -v flutter &> /dev/null; then
  echo "Flutter not found. Install from https://docs.flutter.dev/get-started/install"
  exit 1
fi
flutter --version
ok "Flutter found"

log "Checking Dart..."
dart --version
ok "Dart found"

log "Installing Melos globally..."
dart pub global activate melos
ok "Melos installed"

log "Bootstrapping Melos workspace..."
melos bootstrap
ok "Workspace bootstrapped"

log "Running code generation in all packages..."
melos run gen
ok "Code generation complete"

echo ""
ok "Setup complete! You can now run:"
echo "  melos run run:dev       # Run app (dev flavor)"
echo "  melos run run:staging   # Run app (staging flavor)"
echo "  melos run run:prod      # Run app (prod flavor)"
echo "  melos run test          # Run all tests"
echo "  melos run analyze       # Analyze all packages"
echo "  melos run gen:watch     # Watch mode codegen"