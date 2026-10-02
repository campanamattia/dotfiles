# herdr Cheatsheet

Prefix: `C-a` (same as the old tmux setup). `prefix + ?` lists every live binding.

## Session
| Key | Action |
|-----|--------|
| `herdr` | Launch or attach to the persistent session |
| `herdr --session <name>` | Named session |
| `herdr session attach <name>` | Attach |
| `prefix + d` | Detach |
| `prefix + b` | Toggle sidebar |
| `prefix + w` | Workspace picker |

## Tabs (tmux windows)
| Key | Action |
|-----|--------|
| `prefix + c` | New tab |
| `prefix + r` | Rename tab |
| `prefix + &` | Close tab |
| `prefix + 1-9` | Switch to tab |
| `prefix + p` / `prefix + n` | Previous / next tab |
| `prefix + Shift+←/→` | Move tab left / right |

## Panes (splits)
| Key | Action |
|-----|--------|
| `prefix + \|` | Split vertical |
| `prefix + -` | Split horizontal |
| `prefix + h/j/k/l` | Focus pane |
| `prefix + H/J/K/L` | Resize pane |
| `prefix + C-r` | Resize mode |
| `prefix + x` | Close pane |
| `prefix + z` | Zoom pane |

## Copy / scrollback
| Key | Action |
|-----|--------|
| `prefix + e` | Open scrollback in `$EDITOR` (nvim) — use `v`/`V`/`C-v`/`y` there |
| mouse drag | Copies on select (`copy_on_select`) |

## Misc
| Key | Action |
|-----|--------|
| `prefix + t` | Popup terminal |
| `prefix + s` | Settings |
| `prefix + Shift+r` | Reload config |
| `herdr config check` | Validate `config.toml` |
| `herdr server reload-config` | Reload without restarting |

## Moved from tmux
| tmux | herdr |
|------|-------|
| `C-h/j/k/l` across nvim + panes (vim-tmux-navigator) | `C-h/j/k/l` moves nvim splits only; panes are `prefix + h/j/k/l` |
| `prefix + Escape` vi copy-mode | `prefix + e` scrollback in nvim |
| tmux-yank | `copy_on_select = true` |
| TPM + plugins.conf | built in; no plugin manager step |
