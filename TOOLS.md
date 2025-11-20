# Automated Tool Installation

This document lists all tools that are automatically installed by `install-tools.sh`.

## Usage

```bash
# Interactive (prompts before installing)
./setup.sh

# Fully automatic (no prompts)
./setup.sh --auto

# Only create symlinks, skip tool installation
./setup.sh --no-install

# Standalone tool installation
./install-tools.sh
```

---

## Tools Installed on Ubuntu

### Core Shell & Editor
| Tool | Description | Installation Method |
|------|-------------|-------------------|
| **zsh** | Modern shell | apt |
| **neovim** | Vim-based text editor | PPA (latest unstable) |
| **tmux** | Terminal multiplexer | apt |
| **git** | Version control | apt |

### Zsh Plugins
| Plugin | Description | Location |
|--------|-------------|----------|
| **Powerlevel10k** | Fast, customizable prompt | `/usr/share/powerlevel10k` |
| **zsh-autosuggestions** | Fish-like autosuggestions | `/usr/share/zsh-autosuggestions` |
| **zsh-syntax-highlighting** | Syntax highlighting | `/usr/share/zsh-syntax-highlighting` |

### Modern CLI Tools
| Tool | Description | Alternative Name | Installation |
|------|-------------|------------------|--------------|
| **fzf** | Fuzzy finder | - | apt |
| **bat** | Better cat with syntax highlighting | batcat | apt + symlink |
| **eza** | Modern ls replacement | - | deb repo |
| **ripgrep** (rg) | Fast grep alternative | - | apt |
| **fd** | Fast find alternative | fdfind | apt + symlink |
| **zoxide** | Smart cd (z command) | - | install script |

### Development Tools
| Tool | Description | Installation |
|------|-------------|--------------|
| **gh** | GitHub CLI | GitHub's apt repo |
| **lazygit** | Git TUI client | Latest release |
| **tree** | Directory visualization | apt |
| **jq** | JSON processor | apt |
| **htop** | Process viewer | apt |
| **build-essential** | Compilers & build tools | apt |

### Language Version Managers
| Manager | Languages | Installation | Location |
|---------|-----------|--------------|----------|
| **pyenv** | Python | Install script | `~/.pyenv` |
| **nvm** | Node.js/npm | Install script | `~/.nvm` |
| **rbenv** | Ruby | Git clone | `~/.rbenv` |

---

## Tools Installed on macOS

All tools are installed via **Homebrew** using the `Brewfile`:

```bash
brew bundle --file=~/dotfiles/Brewfile
```

### Core Tools (60+ packages)
The Brewfile includes:
- All the Linux tools above (via Homebrew)
- Additional macOS-specific tools and casks
- GUI applications (Obsidian, etc.)
- Fonts (MesloLGS Nerd Font)
- VS Code extensions

---

## Post-Installation

### Tmux Plugin Manager
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Then in tmux: Ctrl+b followed by I (capital i)
```

### Neovim Plugins
```bash
nvim
# Lazy.nvim will auto-install all plugins
# Or manually: :Lazy sync
```

### Set Default Shell (Linux only)
```bash
chsh -s $(which zsh)
# Log out and back in for changes to take effect
```

---

## Verification

Check what's installed:
```bash
# Core tools
command -v zsh nvim tmux git

# Modern CLI
command -v fzf bat eza rg fd zoxide

# Development
command -v gh lazygit jq tree htop

# Version managers
command -v pyenv
ls ~/.nvm ~/.rbenv
```

Run automated tests:
```bash
# Local (macOS)
./test-local.sh

# Remote (Linux)
./test-remote.sh
```

---

## Customization

To add more tools to Ubuntu installation, edit `install-tools.sh`:

1. Find the relevant function (e.g., `install_dev_tools_ubuntu`)
2. Add your tool installation:
   ```bash
   if ! has_command your-tool; then
       sudo apt-get install -y your-tool
   fi
   ```
3. Test the installation script

For macOS, add to `Brewfile`:
```ruby
brew "your-tool"
```
