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
- Check for required tools (`git`, `zsh`, `nvim`, `tmux`, `ghostty`) and offer to install missing ones
- Symlink `~/.zshrc` → `~/.config/zsh/zshrc` (backing up any existing file)
- Install [TPM](https://github.com/tmux-plugins/tpm) for tmux plugins

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
