#!/usr/bin/env bash
set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

info()    { echo -e "${CYAN}[info]${RESET}  $*"; }
ok()      { echo -e "${GREEN}[ok]${RESET}    $*"; }
warn()    { echo -e "${YELLOW}[warn]${RESET}  $*"; }
section() { echo -e "\n${BOLD}── $* ──${RESET}"; }

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ "$DOTFILES_DIR" != "$HOME/.config" ]]; then
    echo -e "${RED}[error]${RESET} This repo must be cloned into ~/.config"
    echo "        See README.md for instructions."
    exit 1
fi

# ── package manager ───────────────────────────────────────────────────────────
section "Package manager"

detect_pm() {
    if command -v brew   &>/dev/null; then echo brew;   return; fi
    if command -v apt    &>/dev/null; then echo apt;    return; fi
    if command -v dnf    &>/dev/null; then echo dnf;    return; fi
    if command -v pacman &>/dev/null; then echo pacman; return; fi
    echo none
}

PM=$(detect_pm)
if [[ "$PM" == none ]]; then
    warn "No supported package manager found."
    echo "Pick one to use for missing packages:"
    select opt in brew apt dnf pacman "skip (install manually)"; do
        case $opt in
            brew|apt|dnf|pacman) PM=$opt ;;
            *) PM=none ;;
        esac
        break
    done
else
    info "Using: ${BOLD}$PM${RESET}"
fi

install_pkg() {
    local name=$1 pkg=${2:-$1}
    info "Installing $name..."
    case $PM in
        brew)   brew install "$pkg" ;;
        apt)    sudo apt install -y "$pkg" ;;
        dnf)    sudo dnf install -y "$pkg" ;;
        pacman) sudo pacman -S --noconfirm "$pkg" ;;
        none)   warn "Skipping $name — install it manually."; return 1 ;;
    esac
}

# ── required tools ────────────────────────────────────────────────────────────
section "Required tools"

check_tool() {
    local tool=$1 pkg=${2:-$1}
    if command -v "$tool" &>/dev/null; then
        ok "$tool"
    else
        warn "$tool not found"
        read -r -p "  Install $tool? [y/N] " ans
        [[ "${ans,,}" == y ]] && install_pkg "$tool" "$pkg" || true
    fi
}

check_tool git
check_tool zsh
check_tool nvim neovim
check_tool tmux

# ghostty is not in standard repos
if command -v ghostty &>/dev/null; then
    ok "ghostty"
else
    warn "ghostty not found"
    if [[ "$PM" == brew ]]; then
        read -r -p "  Install ghostty? [y/N] " ans
        [[ "${ans,,}" == y ]] && brew install --cask ghostty || true
    else
        warn "Install ghostty manually from: https://ghostty.org/download"
    fi
fi

# ── symlinks ──────────────────────────────────────────────────────────────────
section "Symlinks"

link() {
    local src=$1 dst=$2
    if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
        ok "$dst already linked"; return
    fi
    if [[ -e "$dst" || -L "$dst" ]]; then
        local bak="${dst}.bak.$(date +%Y%m%d%H%M%S)"
        warn "Backing up $dst → $bak"
        mv "$dst" "$bak"
    fi
    ln -s "$src" "$dst"
    ok "Linked $dst → $src"
}

link "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"

# ── tmux plugin manager ───────────────────────────────────────────────────────
section "Tmux Plugin Manager"

TPM_DIR="$HOME/.tmux/plugins/tpm"
if [[ -d "$TPM_DIR" ]]; then
    ok "TPM already installed"
else
    info "Cloning TPM..."
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    ok "TPM installed — open tmux and press prefix + I to install plugins"
fi

# ── done ──────────────────────────────────────────────────────────────────────
section "Done"
info "Neovim plugins install automatically on first launch — just run: nvim"
ok "Setup complete — restart your shell or run: source ~/.zshrc"
