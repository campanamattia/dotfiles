# dotfiles

Personal config for Neovim, tmux, Ghostty, and zsh.

## Setup

> **This repo must be cloned directly into `~/.config`.**
> The install script enforces this and will exit if the path is wrong.

```sh
git clone <repo-url> ~/.config
cd ~/.config
chmod +x install.sh
./install.sh
```

The script will:
- Check for required tools and offer to install missing ones via brew/apt/dnf/pacman:
  `git`, `zsh`, `nvim`, `tmux`, `ghostty`, `fzf`, `zoxide`, `ripgrep`, `make`, `cc`, `node`
- Symlink `~/.zshrc` → `~/.config/zsh/zshrc` (backing up any existing file)
- Clone the zsh plugins sourced by `zsh/prompt` ([fzf-tab](https://github.com/Aloxaf/fzf-tab),
  [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)) into `~/.zsh/`
- Install [TPM](https://github.com/tmux-plugins/tpm) into `~/.tmux/plugins/tpm`

It is idempotent — re-run it any time. Set `ASSUME_YES=1` to install everything without prompting.

After running:
- Open **tmux** and press `prefix + I` to install tmux plugins
- Open **nvim** — lazy.nvim will auto-install all plugins on first launch

## Contents

| Directory | Config for |
|-----------|-----------|
| `nvim/`   | Neovim (lazy.nvim, LSP, treesitter, ...) |
| `tmux/`   | tmux + TPM plugins |
| `ghostty/`| Ghostty terminal |
| `zsh/`    | zsh (prompt, aliases, functions, env) |
