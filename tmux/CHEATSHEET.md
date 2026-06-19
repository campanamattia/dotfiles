# Tmux Cheatsheet

Prefix: `C-a` (Ctrl + a)

## Sessions
| Key | Action |
|-----|--------|
| `tmux` | New session |
| `tmux new -s name` | New named session |
| `tmux ls` | List sessions |
| `tmux a -t name` | Attach to session |
| `prefix + $` | Rename session |
| `prefix + d` | Detach from session |
| `prefix + s` | Switch session |

---

## Windows (tabs)
| Key | Action |
|-----|--------|
| `prefix + c` | New window (in current dir) |
| `prefix + r` | Rename window |
| `prefix + ,` | Rename window (alias) |
| `prefix + &` | Close window |
| `prefix + 1-9` | Switch to window by number |
| `prefix + <` | Swap window left |
| `prefix + >` | Swap window right |

---

## Panes (splits)
| Key | Action |
|-----|--------|
| `prefix + \|` | Split vertical |
| `prefix + -` | Split horizontal |
| `C-h/j/k/l` | Move between panes (and nvim splits) |
| `prefix + H/J/K/L` | Resize pane |
| `prefix + x` | Close pane |
| `prefix + z` | Zoom pane (toggle fullscreen) |

---

## Copy mode
| Key | Action |
|-----|--------|
| `prefix + Escape` | Enter copy mode |
| `v` | Begin selection |
| `V` | Select whole line |
| `C-v` | Rectangle (block) selection |
| `y` | Copy selection |
| `Escape` | Exit copy mode |

---

## Misc
| Key | Action |
|-----|--------|
| `prefix + t` | Open popup terminal |
| `prefix + :` | Command prompt |
| `:vs` | Split vertical (command alias) |
| `:hs` | Split horizontal (command alias) |
| `: source ~/.config/tmux/tmux.conf` | Reload config |
