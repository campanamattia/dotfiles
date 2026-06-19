# Neovim Cheatsheet

## Basics to learn first
| Key | Action |
|-----|--------|
| `i` | Enter insert mode |
| `<esc>` | Back to normal mode / clear search highlight |
| `:w` | Save |
| `:q` | Quit |
| `:wq` | Save and quit |
| `u` | Undo |
| `<C-r>` | Redo |
| `yy` | Copy line |
| `dd` | Cut line |
| `p` | Paste after |
| `v` | Visual mode (select chars) |
| `V` | Visual line mode (select lines) |

---

## Navigation
| Key | Action |
|-----|--------|
| `h j k l` | Left / down / up / right |
| `w` / `b` | Next / prev word |
| `H` | First char of file |
| `L` | Last char of file |
| `<C-d>` | Scroll down half page (centered) |
| `<C-u>` | Scroll up half page (centered) |
| `\` | Jump to column 80 |
| `<C-o>` | Jump back (after gd, telescope, etc.) |
| `<C-i>` | Jump forward |
| `<leader>d` | Open file explorer (side) |
| `<leader>D` | Open file explorer (float) |

---

## Search
| Key | Action |
|-----|--------|
| `/` | Search forward |
| `n` / `N` | Next / prev match (centered) |
| `<leader>f` | Find files |
| `<leader>F` | Find project files (git-aware) |
| `<leader>g` | Fuzzy find in current buffer |
| `<leader>G` | Live grep across project |
| `<leader>k` | List all keymaps |
| `<leader>b` | List open buffers |

---

## Editing
| Key | Action |
|-----|--------|
| `<leader>m` | Duplicate line (normal) / selection (visual) |
| `<C-j>` / `<C-k>` | Move selected lines down / up |
| `>` / `<` | Indent / unindent (keeps visual selection) |
| `J` | Append next line to current (cursor stays) |
| `,` | Insert blank line below (stay in normal) |
| `;` | Insert blank line above (stay in normal) |
| `zc` | Apply first spelling suggestion |

---

## LSP (active when a language server is attached)
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gI` | Go to implementation |
| `gu` | Show references |
| `gs` | Show document symbols |
| `K` | Hover documentation |
| `ga` | Code actions (fixes, refactors) |
| `gr` | Rename symbol |
| `gf` | Format file |
| `<C-s>` | Signature help (insert mode) |

---

## Diagnostics (LSP errors and warnings)
| Key | Action |
|-----|--------|
| `gm` | Show diagnostic message under cursor |
| `ge` | Send all file diagnostics to quickfix |
| `[d` / `]d` | Jump to prev / next diagnostic |

---

## Quickfix
| Key | Action |
|-----|--------|
| `<leader>o` | Toggle quickfix window |
| `<C-p>` / `<C-n>` | Prev / next quickfix entry |

---

## Git (gitsigns)
| Key | Action |
|-----|--------|
| `gp` | Preview changed hunk inline |
| `go` | Reset hunk to last commit |

---

## Harpoon (pinned files)
| Key | Action |
|-----|--------|
| `<leader>a` | Pin current file |
| `<leader>s` | Show pinned files menu |
| `<leader>q` | Jump to pin 1 |
| `<leader>w` | Jump to pin 2 |
| `<leader>e` | Jump to pin 3 |
| `<leader>r` | Jump to pin 4 |
| `<leader>Q` | Prev pinned file |
| `<leader>W` | Next pinned file |

---

## Toggles
| Key | Action |
|-----|--------|
| `<leader>,` | Toggle line wrap |
| `<leader>;` | Toggle frame (line numbers, signs, virtcolumn) |

---

## Tmux navigation
| Key | Action |
|-----|--------|
| `<C-h>` | Move to pane / split left |
| `<C-j>` | Move to pane / split down |
| `<C-k>` | Move to pane / split up |
| `<C-l>` | Move to pane / split right |

---

## Misc
| Key / Command | Action |
|---------------|--------|
| `:DiffOrig` | Diff buffer vs saved file on disk |

---

## Commands
| Type | Expands to |
|------|-----------|
| `hs` | `:split` |
| `vs` | `:vsplit` |
| `msg` | `:MSG` (messages in a split) |
| `git` | `:!git` |
| `it` | `:set spelllang=it` |

| Command | Action |
|---------|--------|
| `:SoloBuf` | Close all buffers except current |
| `:ClearReg` | Wipe all registers |
| `:ToggleFrame` | Same as `<leader>;` |
| `:ToggleWrap` | Same as `<leader>,` |
