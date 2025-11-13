#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="$HOME/bin"
SYSTEM_DIR="/usr/local/bin"

MODE="user"

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

if [ "$MODE" = "system" ]; then
  DEST="$SYSTEM_DIR/voyager"
  echo installing system wide needs sudo
  sudo mkdir -p "$SYSTEM_DIR"
  sudo cp voyager "$DEST"
  sudo chmod +x "$DEST"
  echo installed to $DEST
  exit 0
fi

DEST="$INSTALL_DIR/voyager"

mkdir -p "$INSTALL_DIR"
cp voyager "$DEST"
chmod +x "$DEST"

if ! echo "$PATH" | grep -q "$HOME/bin"; then
  echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bashrc"
  echo added home bin to bashrc open new terminal
fi

echo installed to $DEST
echo run voyager now

