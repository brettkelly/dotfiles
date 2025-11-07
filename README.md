# Brett's Dotfiles

Modern macOS development environment configuration focused on Neovim, Zsh, and Tmux.

## What's Included

### Core Configurations
- **Shell**: Zsh with Powerlevel10k prompt, autosuggestions, syntax highlighting
- **Editor**: Neovim (Lua-based) with LSP, completion, and extensive plugins
- **Terminal**: Ghostty terminal emulator (Catppuccin theme)
- **Multiplexer**: Tmux with vim-style navigation and Catppuccin theme
- **Version Control**: Git with global ignore patterns

### Development Tools
- **Languages**: Python (pyenv, Poetry), Node (NVM), PHP (multiple versions), Ruby (rbenv)
- **LSP Servers**: Configured via Mason (PHP/Intelephense, and more)
- **Package Management**: Homebrew with comprehensive Brewfile
- **Cloud**: AWS CLI and SAM CLI
- **Utilities**: 35+ custom shell scripts for various tasks

### Highlights
- XDG Base Directory compliant (`.config/` for configs)
- Modern CLI tools: `bat`, `eza`, `zoxide`, `fzf`
- WordPress/PHP development optimized
- Markdown/prose writing support (Obsidian.nvim, vim-pencil)
- Extensive collection of custom utilities

## Prerequisites

- macOS (tested on macOS Sonoma 14.6+)
- Git
- Basic command line knowledge

## Installation

### 1. Clone this repository

```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Run the setup script

```bash
./setup.sh
```

This will:
- Backup any existing configurations to `~/.dotfiles_backup_<timestamp>`
- Create symlinks from your home directory to the dotfiles
- Show you next steps for installing dependencies

### 3. Install Homebrew (if not already installed)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 4. Install all packages and applications

```bash
brew bundle --file=~/dotfiles/Brewfile
```

This installs:
- 60+ CLI tools (git, neovim, python, node, etc.)
- Fonts (MesloLGS Nerd Font)
- Applications (Obsidian, 1Password CLI, etc.)
- VSCode extensions

### 5. Install Tmux Plugin Manager

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Then in tmux, press `prefix + I` (default: `Ctrl+b` then `I`) to install plugins.

### 6. Install Zsh plugins

The configuration uses Powerlevel10k, zsh-autosuggestions, and zsh-syntax-highlighting. Install them:

```bash
# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
```

### 7. Reload your shell

```bash
exec zsh
```

If Powerlevel10k doesn't automatically start configuration, run:
```bash
p10k configure
```

### 8. Install Neovim plugins

Open Neovim, and Lazy.nvim will automatically install all plugins:

```bash
nvim
```

Wait for all plugins to install, then restart Neovim.

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

## Troubleshooting

### Fonts look weird
Install MesloLGS Nerd Font: `brew install font-meslo-lg-nerd-font`

### Zsh plugins not working
Make sure you've cloned the plugin repositories (see step 6 above).

### Neovim LSP not working
Open Neovim and run `:checkhealth` to diagnose issues.

### Tmux plugins not loading
Install TPM and press `prefix + I` in tmux to install plugins.

## Notes

- **Archive folder**: Contains legacy configs (WezTerm, iTerm2) for reference
- **Cache files**: `.local/share/`, `.local/lib/`, and `.poetry/` are gitignored and regenerated on install
- **PHP Focus**: Heavily optimized for WordPress/PHP development
- **Completion**: Both nvim-cmp and blink.cmp are configured while evaluating performance

## License

Feel free to use and modify for your own dotfiles!
