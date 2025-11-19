#!/usr/bin/env bash
set -euo pipefail

# ----------------------------------------
# CONFIG
# ----------------------------------------
VOYAGER_SCRIPT="voyager"
INSTALL_SYSTEM=false

# ----------------------------------------
# PARSE FLAGS
# ----------------------------------------
if [[ "${1:-}" == "--system" ]]; then
    INSTALL_SYSTEM=true
fi

# ----------------------------------------
# FUNCTIONS
# ----------------------------------------

need_cmd() {
    command -v "$1" >/dev/null 2>&1
}

install_dep_system() {
    local pkg="$1"
    if ! need_cmd "$pkg"; then
        echo "dependency missing: $pkg (installing)"
        apt-get update -y >/dev/null
        apt-get install -y "$pkg" >/dev/null
    fi
}

check_dep_user() {
    local pkg="$1"
    if ! need_cmd "$pkg"; then
        echo "WARNING: required command '$pkg' not found."
        echo "Install it manually:"
        echo "  sudo apt install $pkg"
        echo ""
    fi
}

# ----------------------------------------
# SYSTEM MODE INSTALL
# ----------------------------------------
if $INSTALL_SYSTEM; then
    echo "[system install] installing voyager into /usr/local/bin"

    # install deps
    install_dep_system curl
    install_dep_system bc

    # copy script
    install -m 0755 "$VOYAGER_SCRIPT" /usr/local/bin/

    echo "done."
    exit 0
fi

# ----------------------------------------
# USER MODE INSTALL
# ----------------------------------------
echo "[user install] installing voyager into ~/bin"

# warn but do not install dependencies
check_dep_user curl
check_dep_user bc

# ensure ~/bin exists
mkdir -p "$HOME/bin"

# copy script
cp "$VOYAGER_SCRIPT" "$HOME/bin/"
chmod +x "$HOME/bin/voyager"

# ensure PATH contains ~/bin
if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
    echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bashrc"
    echo "added ~/bin to PATH in ~/.bashrc"
fi

echo "done."
echo ""
echo "open a new terminal or run:"
echo "    source ~/.bashrc"

