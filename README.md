# dotfiles

Personal config for Neovim, herdr, Ghostty, and zsh.

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
  `git`, `zsh`, `nvim`, `herdr`, `ghostty`, `fzf`, `zoxide`, `ripgrep`, `fd`, `make`, `cc`, `node`, `curl`, `unzip`
- Symlink `~/.zshrc` → `~/.config/zsh/zshrc` (backing up any existing file)
- Retire any `~/.gitconfig` so `git/config` is read natively from `~/.config/git/`
- Clone the zsh plugins sourced by `zsh/prompt` ([fzf-tab](https://github.com/Aloxaf/fzf-tab),
  [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)) into `~/.zsh/`
- Sync Neovim plugins headlessly (`nvim --headless +Lazy! sync`) so the first launch isn't a cold build

It is idempotent — re-run it any time. Set `ASSUME_YES=1` to install everything without prompting.

After running:
- Run **herdr** to start the session — see `herdr/CHEATSHEET.md` (prefix `C-a`)
- Open **nvim** — treesitter parsers and LSP servers (mason) finish installing on first launch

## Contents

| Directory | Config for |
|-----------|-----------|
| `nvim/`   | Neovim (lazy.nvim, LSP, treesitter, ...) |
| `herdr/`  | herdr terminal workspace (prefix `C-a`) |
| `ghostty/`| Ghostty terminal |
| `zsh/`    | zsh (prompt, aliases, functions, env) |
| `git/`   | global git config + ignore (read natively from `~/.config/git/`) |
