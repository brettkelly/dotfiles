#!/bin/bash

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Parse command line arguments
AUTO_INSTALL=false
SKIP_INSTALL=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --auto|--yes|-y)
            AUTO_INSTALL=true
            shift
            ;;
        --no-install)
            SKIP_INSTALL=true
            shift
            ;;
        --help|-h)
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --auto, --yes, -y    Automatically install all tools without prompting"
            echo "  --no-install         Skip tool installation (only create symlinks)"
            echo "  --help, -h           Show this help message"
            echo ""
            echo "Examples:"
            echo "  $0                   Interactive mode (will prompt for tool installation)"
            echo "  $0 --auto            Automatic mode (installs everything)"
            echo "  $0 --no-install      Only create symlinks, skip tool installation"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Run '$0 --help' for usage information"
            exit 1
            ;;
    esac
done

echo -e "${GREEN}=== Dotfiles Setup ===${NC}\n"

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

# Detect platform
OS="$(uname -s)"
case "$OS" in
    Darwin*)
        PLATFORM="macos"
        ;;
    Linux*)
        PLATFORM="linux"
        ;;
    *)
        PLATFORM="unknown"
        ;;
esac

echo "Platform detected: $PLATFORM"
echo "Dotfiles directory: $DOTFILES_DIR"
echo "Backup directory: $BACKUP_DIR"
echo ""

# Files to symlink from dotfiles to home directory
FILES=(
    ".aliases"
    ".config"
    ".digrc"
    ".hushlogin"
    ".linux.zsh"
    ".local"
    ".profile"
    ".tmux.conf"
    ".zprofile"
    ".zsh"
    ".zshrc"
)

# Function to backup existing file/directory
backup_if_exists() {
    local target="$1"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo -e "${YELLOW}Backing up existing $target${NC}"
        mkdir -p "$BACKUP_DIR"
        mv "$target" "$BACKUP_DIR/"
    elif [ -L "$target" ]; then
        echo -e "${YELLOW}Removing existing symlink $target${NC}"
        rm "$target"
    fi
}

# Create symlinks
for file in "${FILES[@]}"; do
    source_file="$DOTFILES_DIR/$file"
    target_file="$HOME/$file"

    # Check if source exists
    if [ ! -e "$source_file" ]; then
        echo -e "${RED}⚠ Skipping $file (not found in dotfiles)${NC}"
        continue
    fi

    # Backup existing file/dir if it exists
    backup_if_exists "$target_file"

    # Create symlink
    ln -s "$source_file" "$target_file"
    echo -e "${GREEN}✓ Linked $file${NC}"
done

echo ""
echo -e "${GREEN}=== Setup Complete! ===${NC}"

if [ -d "$BACKUP_DIR" ]; then
    echo -e "${YELLOW}Backups saved to: $BACKUP_DIR${NC}"
fi

echo ""

# Handle tool installation based on flags
if [ "$SKIP_INSTALL" = true ]; then
    echo -e "${YELLOW}Skipping tool installation (--no-install flag)${NC}"
elif [ "$AUTO_INSTALL" = true ]; then
    echo -e "${GREEN}Auto-installing tools (--auto flag)...${NC}"
    if [ -x "$DOTFILES_DIR/install-tools.sh" ]; then
        "$DOTFILES_DIR/install-tools.sh"
    else
        echo -e "${RED}install-tools.sh not found or not executable${NC}"
        exit 1
    fi
else
    # Interactive mode - ask user
    echo -e "${BLUE}Would you like to install required tools now? (y/n)${NC}"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        if [ -x "$DOTFILES_DIR/install-tools.sh" ]; then
            echo ""
            echo -e "${GREEN}Running install-tools.sh...${NC}"
            "$DOTFILES_DIR/install-tools.sh"
        else
            echo -e "${RED}install-tools.sh not found or not executable${NC}"
        fi
    else
        echo ""
        echo "Skipping tool installation."
    fi
fi

echo ""
echo "Next steps:"

if [ "$PLATFORM" = "macos" ]; then
    echo "  macOS-specific instructions:"
    echo "  1. Homebrew should be installed (or run: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\")"
    echo "  2. Install packages: brew bundle --file=$DOTFILES_DIR/Brewfile"
elif [ "$PLATFORM" = "linux" ]; then
    echo "  Linux-specific instructions:"
    echo "  1. Run the installation script if you haven't already: $DOTFILES_DIR/install-tools.sh"
    echo "  2. Ensure all tools are installed (zsh, neovim, tmux, etc.)"
else
    echo "  Unknown platform. Please install tools manually."
fi

echo ""
echo "  Common next steps (all platforms):"
echo "  1. Install Tmux Plugin Manager: git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm"
echo "  2. Reload shell: exec zsh (or logout and login again)"
echo "  3. In tmux, press prefix + I (capital i) to install plugins"
echo "  4. Open nvim and run :Lazy sync to install plugins"
