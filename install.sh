#!/usr/bin/env bash
set -euo pipefail

# URLs for downloading voyager and installer
BASE_URL="https://raw.githubusercontent.com/oneSevenAR/Voyager-CLI/main"
VOYAGER_URL="$BASE_URL/voyager"

INSTALL_DIR="$HOME/bin"
SYSTEM_DIR="/usr/local/bin"

MODE="user"

# Parse arguments (default = user mode)
for arg in "$@"; do
  case "$arg" in
    --system)
      MODE="system"
      ;;
    --user)
      MODE="user"
      ;;
  esac
done

# Determine source location of voyager
if [ -f "./voyager" ]; then
  SOURCE_LOCAL="./voyager"
else
  SOURCE_LOCAL=""
fi

download_voyager() {
  echo "Downloading voyager from $VOYAGER_URL..."
  curl -fsSL "$VOYAGER_URL" -o voyager_temp
  chmod +x voyager_temp
}

#########################################
# SYSTEM INSTALLATION MODE
#########################################

if [ "$MODE" = "system" ]; then
  DEST="$SYSTEM_DIR/voyager"

  echo "Installing system-wide (requires sudo)..."
  sudo mkdir -p "$SYSTEM_DIR"

  if [ -n "$SOURCE_LOCAL" ]; then
    sudo cp "$SOURCE_LOCAL" "$DEST"
  else
    download_voyager
    sudo cp voyager_temp "$DEST"
    rm -f voyager_temp
  fi

  sudo chmod +x "$DEST"
  echo "Installed system-wide at: $DEST"
  exit 0
fi

#########################################
# USER INSTALLATION MODE
#########################################

DEST="$INSTALL_DIR/voyager"

mkdir -p "$INSTALL_DIR"

if [ -n "$SOURCE_LOCAL" ]; then
  cp "$SOURCE_LOCAL" "$DEST"
else
  download_voyager
  mv voyager_temp "$DEST"
fi

chmod +x "$DEST"

# Add ~/bin to PATH if missing
if ! echo "$PATH" | grep -q "$HOME/bin"; then
  echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bashrc"
  echo "Added ~/bin to your PATH in ~/.bashrc."
  echo "Open a new terminal for changes to take effect."
fi

echo "Installation complete."
echo "Run 'voyager' to test."

