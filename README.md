# Brett's Dotfiles

Modern, portable development environment configuration focused on Neovim, Zsh, and Tmux.
Works seamlessly on both **macOS** and **Linux (Ubuntu)**.

## What's Included

### Core Configurations
- **Shell**: Zsh with Powerlevel10k prompt, autosuggestions, syntax highlighting
- **Editor**: Neovim (Lua-based) with LSP, completion, and extensive plugins
- **Terminal**: Ghostty terminal emulator (Catppuccin theme) on macOS
- **Multiplexer**: Tmux with vim-style navigation and Catppuccin theme
- **Version Control**: Git with global ignore patterns

### Development Tools
- **Languages**: Python (pyenv, Poetry), Node (NVM), PHP (multiple versions), Ruby (rbenv)
- **LSP Servers**: Configured via Mason (PHP/Intelephense, Python/Pyright, Lua, HTML/CSS, and more)
- **Package Management**:
  - macOS: Homebrew with comprehensive Brewfile
  - Linux: apt with automatic installation script
- **Cloud**: AWS CLI and SAM CLI
- **Utilities**: 35+ custom shell scripts for various tasks

### Highlights
- **Portable**: Works on both macOS and Linux (Ubuntu/Debian)
- **Dynamic path detection**: Automatically finds tools regardless of installation location
- **XDG Base Directory compliant** (`.config/` for configs)
- **Modern CLI tools**: `bat`, `eza`, `zoxide`, `fzf`, `ripgrep`, `fd`
- **WordPress/PHP development** optimized
- **Markdown/prose writing** support (Obsidian.nvim, vim-pencil)
- **Extensive collection** of custom utilities

## Prerequisites

### All Platforms
- Git
- Basic command line knowledge
- Sudo access (for package installation)

### Platform-Specific
- **macOS**: Tested on macOS Sonoma 14.6+ (Apple Silicon and Intel)
- **Linux**: Ubuntu 20.04+ or Debian-based distributions

## Installation

### Quick Start (Automated)

**All platforms:**

```bash
# Clone this repository
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Run the setup script
./setup.sh
```

The setup script will:
1. Detect your platform (macOS or Linux)
2. Backup any existing configurations to `~/.dotfiles_backup_<timestamp>`
3. Create symlinks from your home directory to the dotfiles
4. Offer to install required tools automatically
5. Show platform-specific next steps

When prompted, answer **yes** to install tools automatically. This will run `install-tools.sh` which handles platform-specific package installation.

### Manual Installation

If you prefer manual control or the automated script fails:

<details>
<summary><strong>macOS Installation</strong></summary>

#### 1. Clone and setup

```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

#### 2. Install Homebrew (if not already installed)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### 3. Install packages via Homebrew

```bash
brew bundle --file=~/dotfiles/Brewfile
```

This installs 60+ tools including:
- Core: git, zsh, neovim, tmux
- Modern CLI: bat, eza, fzf, ripgrep, fd, zoxide
- Languages: python, node, php, ruby
- Development: gh (GitHub CLI), lazygit, docker
- Fonts: MesloLGS Nerd Font
- Apps: Obsidian, 1Password CLI
- VSCode extensions

#### 4. Install Tmux Plugin Manager

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

#### 5. Reload shell

```bash
exec zsh
```

If Powerlevel10k config doesn't start automatically: `p10k configure`

</details>

<details>
<summary><strong>Linux (Ubuntu) Installation</strong></summary>

#### 1. Clone and setup

```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

#### 2. Install all tools

```bash
./install-tools.sh
```

This script will:
- Update apt repositories
- Install zsh, neovim (latest from PPA), tmux
- Install zsh plugins (Powerlevel10k, autosuggestions, syntax-highlighting)
- Install modern CLI tools (bat, eza, fzf, ripgrep, fd, zoxide)
- Install development tools (git, gh, build-essential)
- Install version managers (pyenv, nvm, rbenv)

The script uses `sudo` for system package installation.

#### 3. Install Tmux Plugin Manager

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

#### 4. Set zsh as default shell (if not prompted during install-tools.sh)

```bash
chsh -s $(which zsh)
```

You'll need to log out and back in for this to take effect.

#### 5. Reload shell

```bash
exec zsh
```

If Powerlevel10k config doesn't start automatically: `p10k configure`

</details>

### Post-Installation (All Platforms)

#### 1. Start tmux and install plugins

```bash
tmux
# Then press: Ctrl+b followed by I (capital i)
```

#### 2. Install Neovim plugins

```bash
nvim
# Lazy.nvim will automatically install all plugins
# Wait for completion, then restart nvim
```

#### 3. Configure Powerlevel10k (if not done automatically)

```bash
p10k configure
```

## Directory Structure

```
dotfiles/
├── .config/              # XDG-compliant configurations
│   ├── nvim/            # Neovim Lua configuration
│   ├── ghostty/         # Ghostty terminal config
│   ├── git/             # Git global ignore
│   └── ...
├── .local/
│   ├── bin/             # Custom shell scripts (35+ utilities)
│   └── state/           # Runtime state files
├── .tmux/               # Tmux plugin manager & plugins
├── .ssh/                # SSH configuration
├── .zsh/                # Zsh custom configs
├── archive/             # Legacy configs (reference only)
├── vscode/              # VSCode settings
├── .aliases             # Command aliases
├── .profile             # Environment variables
├── .zshrc               # Main Zsh configuration
├── .p10k.zsh            # Powerlevel10k theme config
├── .tmux.conf           # Tmux configuration
├── Brewfile             # Homebrew bundle
└── setup.sh             # Installation script
```

## Custom Scripts

Located in `.local/bin/`, categorized by purpose:

### WordPress Development
- `wpdocker` - WordPress Docker environment helper
- `newplug` - Create new WordPress plugin from template
- `getwppages` - Fetch WordPress pages

### Network/DNS Tools
- `dnsc` - Check DNS propagation across multiple servers
- `glip` - IP geolocation lookup
- `dinfo` - Comprehensive domain information
- `checkserver` - SSH server diagnostics

### Media Processing
- `split-video` - Split videos
- `vidthumb` - Generate video thumbnails
- `pdfshrink` - Compress PDFs
- `md2docx` - Convert Markdown to DOCX

### Development Utilities
- `tmuxstart` - Start tmux with common sessions
- `mksc` - Create scratch vim buffer
- `gcp` - Git copy helper
- `extract` - Universal archive extraction

## Key Features

### Neovim
- **Leader**: `Space`
- **LSP**: Full language server support via Mason
- **Completion**: nvim-cmp and blink.cmp (evaluating both)
- **File Navigation**: Telescope (fuzzy finder), nvim-tree (file explorer)
- **Git**: Lazygit integration
- **Theme**: Catppuccin

Key bindings (leader = Space):
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>e` - Toggle file explorer
- `<leader>gg` - Open Lazygit

### Tmux
- **Prefix**: `Ctrl+b` (default)
- **Theme**: Catppuccin Frappe
- **Navigation**: Vim-style (`h`, `j`, `k`, `l` for pane movement)
- **Mouse**: Enabled

### Zsh
- **Prompt**: Powerlevel10k (fast, informative)
- **Navigation**: `z` (zoxide) for smart directory jumping
- **Search**: `Ctrl+R` for fuzzy history search (fzf)
- **Completion**: Smart completions with autosuggestions

## Customization

### Adding Your Own Scripts
Place executable scripts in `.local/bin/` and they'll be automatically in your PATH.

### Modifying Neovim
- Plugins: Add files to `.config/nvim/lua/brettkelly/plugins/`
- Keybindings: Edit `.config/nvim/lua/brettkelly/core/keymaps.lua`
- Options: Edit `.config/nvim/lua/brettkelly/core/options.lua`

### Shell Aliases
Edit `.aliases` and reload with `source ~/.zshrc`

## Updating

Pull latest changes and the symlinks will automatically reflect updates:

```bash
cd ~/dotfiles
git pull
```

For Neovim plugins:
```bash
nvim
:Lazy sync
```

For Homebrew packages:
```bash
brew bundle --file=~/dotfiles/Brewfile
```

## Platform Differences

### What's Different on Linux vs macOS?

**Automatic Adaptations:**
- **Package manager**: Homebrew (macOS) vs apt (Ubuntu)
- **Tool paths**: Dynamically detected (no hardcoded paths)
- **Zsh plugin locations**: `/opt/homebrew/share/` vs `/usr/share/`
- **Clipboard**: `pbcopy/pbpaste` (macOS) vs `xclip/xsel` (Linux)
- **Tool names**: Some tools have different names on Ubuntu (e.g., `batcat` → `bat`)

**Platform-Specific Files:**
- `.linux.zsh`: Loaded only on Linux, contains Linux-specific aliases and configs
- All core configs work identically on both platforms

### How Portability Works

The dotfiles use several mechanisms to work across platforms:

1. **Platform detection**: `.local/lib/platform.sh` provides helper functions
2. **Dynamic path resolution**: Tools are found via `command -v` instead of hardcoded paths
3. **Conditional loading**: Configuration files check OS and adapt behavior
4. **Fallback chains**: Multiple possible locations checked for each tool

## Troubleshooting

### Fonts look weird
**macOS**: `brew install font-meslo-lg-nerd-font`
**Linux**: Download from [Nerd Fonts](https://www.nerdfonts.com/), install to `~/.local/share/fonts/`

### Zsh plugins not working
Run the install script again: `./install-tools.sh`
Or install manually (see Manual Installation section above)

### Neovim LSP not working
Open Neovim and run `:checkhealth` to diagnose issues.
LSP servers install automatically via Mason, but you can manually trigger: `:Mason`

### Tmux plugins not loading
Install TPM: `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
Then in tmux: `prefix + I` (Ctrl+b then Shift+i)

### Command not found errors on Linux
Some tools may have different names:
- `bat` might be `batcat` (alias is set automatically in `.linux.zsh`)
- `fd` might be `fdfind` (alias is set automatically)

### Shell doesn't change to zsh on Linux
Run: `chsh -s $(which zsh)` and log out/in again

## Notes

- **Portability**: These dotfiles work on both macOS and Linux (Ubuntu/Debian) with automatic platform detection
- **Archive folder**: Contains legacy configs (WezTerm, iTerm2) for reference
- **Cache files**: `.local/share/`, `.local/lib/`, and `.poetry/` are gitignored and regenerated on install
- **PHP Focus**: Heavily optimized for WordPress/PHP development
- **Completion**: Both nvim-cmp and blink.cmp are configured while evaluating performance
- **Remote servers**: Perfect for maintaining consistent environments on remote Linux machines

## Contributing

Found an issue or want to add support for another Linux distribution?
- For bugs: Open an issue with platform details (OS, version)
- For new distros: Add package manager support to `install-tools.sh`

## Testing

Tested on:
- macOS Sonoma 14.6+ (Apple Silicon and Intel)
- Ubuntu 22.04 LTS
- Ubuntu 24.04 LTS

Should work on any Debian-based Linux distribution with minor adjustments.

## License

Feel free to use and modify for your own dotfiles!
