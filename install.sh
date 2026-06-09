#!/bin/bash
set -euo pipefail

# ---------------------------------------------------------------------------
# install.sh — bootstrap a new Ubuntu/Debian machine with these dotfiles.
#
# Requirements: Ubuntu / Debian (uses apt). Exits early on other systems.
# Safe to re-run: existing correct symlinks are skipped; other files are
# backed up to ~/.dotfiles-backup/<timestamp>/ before being replaced.
# ---------------------------------------------------------------------------

# --- Guard: Ubuntu/Debian only ----------------------------------------------
if ! command -v apt-get >/dev/null 2>&1; then
    echo "ERROR: This script requires apt-get (Ubuntu/Debian only)." >&2
    exit 1
fi

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"

_created=0
_skipped=0
_backed_up=0

# --- Helpers ----------------------------------------------------------------

# link <repo_file> <target_path> [dir]
#   dir = "y"  → use ln -sn (directory links)
#   Backs up target if it exists and is not already the correct symlink.
link() {
    local src="$1"
    local dst="$2"
    local is_dir="${3:-}"

    # Already the correct symlink → skip
    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
        echo "  skip  $dst (already correct)"
        (( _skipped++ )) || true
        return
    fi

    # Exists but wrong → back up
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        mkdir -p "$BACKUP_DIR"
        mv "$dst" "$BACKUP_DIR/"
        echo "  backup $dst → $BACKUP_DIR/"
        (( _backed_up++ )) || true
    fi

    mkdir -p "$(dirname "$dst")"
    if [ "$is_dir" = "y" ]; then
        ln -sn "$src" "$dst"
    else
        ln -s "$src" "$dst"
    fi
    echo "  link  $src → $dst"
    (( _created++ )) || true
}

# ---------------------------------------------------------------------------
# 1. System packages
# ---------------------------------------------------------------------------
echo "==> Installing system packages..."
sudo apt-get update -q
sudo apt-get install -y \
    alacritty curl git luarocks vim-gtk3 fzf python3-venv \
    tmux tmux-plugin-manager colordiff xclip wl-clipboard \
    make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev libncursesw5-dev xz-utils \
    tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# ---------------------------------------------------------------------------
# 2. uv (Python env manager)
# ---------------------------------------------------------------------------
echo "==> Installing uv..."
curl -LsSf https://astral.sh/uv/install.sh | sh

# ---------------------------------------------------------------------------
# 3. Starship prompt
# ---------------------------------------------------------------------------
if ! command -v starship >/dev/null 2>&1; then
    echo "==> Installing starship..."
    sudo mkdir -p /usr/local/bin
    curl -fsSL https://starship.rs/install.sh | sudo sh -s -- -y --bin-dir /usr/local/bin
else
    echo "==> starship already installed, skipping."
fi

# ---------------------------------------------------------------------------
# 4. Neovim (latest release from neovim/neovim-releases)
# ---------------------------------------------------------------------------
if ! command -v nvim >/dev/null 2>&1; then
    echo "==> Installing neovim..."
    TMPDIR="$(mktemp -d)"
    trap 'rm -rf "$TMPDIR"' EXIT

    latest=$(git ls-remote --tags https://github.com/neovim/neovim-releases \
        | grep -Eo 'refs/tags/v([0-9]+(\.)?)+' \
        | sort -r | head -n1 | cut -f3 -d'/')
    wget -q -O "$TMPDIR/nvim.deb" \
        "https://github.com/neovim/neovim-releases/releases/download/${latest}/nvim-linux-x86_64.deb"
    sudo dpkg -i "$TMPDIR/nvim.deb"
    trap - EXIT
    rm -rf "$TMPDIR"
else
    echo "==> neovim already installed, skipping."
fi

# ---------------------------------------------------------------------------
# 5. Mononoki Nerd Font
# ---------------------------------------------------------------------------
if ls "$HOME"/.fonts/MononokiNerdFont* >/dev/null 2>&1; then
    echo "==> Mononoki Nerd Font already installed, skipping."
else
    echo "==> Installing Mononoki Nerd Font..."
    TMPDIR="$(mktemp -d)"
    trap 'rm -rf "$TMPDIR"' EXIT
    mkdir -p "$HOME/.fonts"
    wget -q -O "$TMPDIR/Mononoki.zip" \
        "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Mononoki.zip"
    unzip -o "$TMPDIR/Mononoki.zip" -d "$HOME/.fonts/"
    fc-cache -f -v
    trap - EXIT
    rm -rf "$TMPDIR"
fi

# ---------------------------------------------------------------------------
# 6. SSH authorized_keys (only for the repo owner)
# ---------------------------------------------------------------------------
if [[ "${USER:-}" == 'xortiz' ]]; then
    echo "==> Setting up authorized_keys..."
    mkdir -p "$HOME/.ssh"
    while IFS= read -r key; do
        if [[ -n "$key" ]]; then
            key_fingerprint=$(echo "$key" | ssh-keygen -lf - 2>/dev/null | awk '{print $2}')
            if [[ -n "$key_fingerprint" ]] && \
               ! grep -q "$key_fingerprint" <(ssh-keygen -lf "$HOME/.ssh/authorized_keys" 2>/dev/null); then
                echo "$key" >> "$HOME/.ssh/authorized_keys"
            fi
        fi
    done < "$REPO_DIR/ssh/authorized_keys"
fi

# ---------------------------------------------------------------------------
# 7. Timezone + locale
# ---------------------------------------------------------------------------
echo "==> Setting timezone and locale..."
sudo ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
sudo localectl set-locale LANG=en_US.UTF-8 2>/dev/null || true

# ---------------------------------------------------------------------------
# 8. Symlinks
# ---------------------------------------------------------------------------
echo "==> Creating symlinks..."

mkdir -p "$HOME/.config"

link "$REPO_DIR/vimrc"                 "$HOME/.vimrc"
link "$REPO_DIR/tmux.conf"             "$HOME/.tmux.conf"
link "$REPO_DIR/bashrc"                "$HOME/.bashrc"
link "$REPO_DIR/config/nvim"           "$HOME/.config/nvim"      y
link "$REPO_DIR/config/ghostty"        "$HOME/.config/ghostty"   y
link "$REPO_DIR/config/alacritty"      "$HOME/.config/alacritty" y
link "$REPO_DIR/config/wezterm"        "$HOME/.config/wezterm"   y
link "$REPO_DIR/config/vale"           "$HOME/.config/vale"      y
link "$REPO_DIR/config/starship.toml"  "$HOME/.config/starship.toml"

# Vale ↔ Neovim shared spell vocabulary.
# The spell file is gitignored (per-machine vocab); create it if absent so
# the symlink is never dangling on a fresh clone.
VALE_DICT_DIR="$HOME/.local/share/vale/styles/config/vocabularies/nvimDict"
mkdir -p "$VALE_DICT_DIR"
mkdir -p "$REPO_DIR/config/nvim/spell"
if [ ! -f "$REPO_DIR/config/nvim/spell/en.utf-8.add" ]; then
    touch "$REPO_DIR/config/nvim/spell/en.utf-8.add"
fi
link "$REPO_DIR/config/nvim/spell/en.utf-8.add" "$VALE_DICT_DIR/accept.txt"

# ---------------------------------------------------------------------------
# Done
# ---------------------------------------------------------------------------
echo ""
echo "==> Done."
echo "    Symlinks created : $_created"
echo "    Already correct  : $_skipped"
echo "    Backed up        : $_backed_up"
if [ "$_backed_up" -gt 0 ]; then
    echo "    Backups saved to : $BACKUP_DIR"
fi
