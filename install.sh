#!/usr/bin/env bash
set -euo pipefail

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; BOLD='\033[1m'; R='\033[0m'
info() { echo -e "${CYAN}[info]${R}  $*"; }
ok()   { echo -e "${GREEN}[ok]${R}    $*"; }
warn() { echo -e "${YELLOW}[warn]${R}  $*"; }
section() { echo -e "\n${BOLD}── $* ──${R}"; }

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ "$DOTFILES_DIR" != "$HOME/.config" ]]; then
    echo -e "${RED}[error]${R} This repo must be cloned into ~/.config (see README.md)"
    exit 1
fi

# yes/no prompt; ASSUME_YES=1 or no tty answers yes
ask() {
    [[ -n "${ASSUME_YES:-}" || ! -t 0 ]] && return 0
    local ans
    read -r -p "  $1 [y/N] " ans
    [[ "$ans" == [yY]* ]]
}

# ── package manager ───────────────────────────────────────────────────────────
section "Package manager"

for pm in brew apt-get dnf pacman; do
    command -v "$pm" &>/dev/null && PM=$pm && break
done
PM=${PM:-none}
[[ "$PM" == none ]] && warn "No supported package manager — missing tools must be installed manually." \
                    || info "Using: ${BOLD}$PM${R}"

install_pkg() {
    case $PM in
        brew)    brew install "$1" ;;
        apt-get) sudo apt-get install -y "$1" ;;
        dnf)     sudo dnf install -y "$1" ;;
        pacman)  sudo pacman -S --noconfirm "$1" ;;
        none)    return 1 ;;
    esac
}

# need <command> [package] — package defaults to command name
need() {
    local cmd=$1 pkg=${2:-$1}
    if command -v "$cmd" &>/dev/null; then
        ok "$cmd"
    elif [[ "$PM" == none ]]; then
        warn "$cmd not found — install '$pkg' manually"
    else
        warn "$cmd not found"
        ask "Install $pkg?" && install_pkg "$pkg" || warn "Skipped $cmd"
    fi
}

# ── tools ─────────────────────────────────────────────────────────────────────
section "Tools"

need git
need zsh
need nvim neovim
need tmux
need fzf                 # zsh completion popup, fzf-tab
need zoxide              # cd replacement in zsh/prompt
need rg ripgrep          # telescope live_grep
need make                # telescope-fzf-native, treesitter parsers
need cc gcc              # treesitter parser compilation
need node                # mason: ts_ls, pyright

if command -v ghostty &>/dev/null; then
    ok "ghostty"
elif [[ "$PM" == brew ]]; then
    warn "ghostty not found"
    ask "Install ghostty?" && brew install --cask ghostty || warn "Skipped ghostty"
else
    warn "ghostty not found — install from https://ghostty.org/download"
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

# ── git-cloned plugins ────────────────────────────────────────────────────────
section "Plugins"

clone() {
    local url=$1 dst=$2
    if [[ -d "$dst/.git" ]]; then
        ok "$(basename "$dst") already installed"
    else
        info "Cloning $(basename "$dst")..."
        git clone --depth 1 "$url" "$dst" && ok "$(basename "$dst")"
    fi
}

# sourced by zsh/prompt
clone https://github.com/Aloxaf/fzf-tab                        "$HOME/.zsh/fzf-tab"
clone https://github.com/zsh-users/zsh-syntax-highlighting     "$HOME/.zsh/zsh-syntax-highlighting"
# run by tmux/plugins.conf
clone https://github.com/tmux-plugins/tpm                      "$HOME/.tmux/plugins/tpm"

# ── done ──────────────────────────────────────────────────────────────────────
section "Done"
info "tmux: press prefix + I to install tmux plugins"
info "nvim: lazy.nvim installs plugins on first launch — just run: nvim"
ok "Restart your shell or run: source ~/.zshrc"
