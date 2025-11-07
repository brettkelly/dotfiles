#!/bin/bash

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Dotfiles Setup ===${NC}\n"

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

echo "Dotfiles directory: $DOTFILES_DIR"
echo "Backup directory: $BACKUP_DIR"
echo ""

# Files to symlink from dotfiles to home directory
FILES=(
    ".aliases"
    ".config"
    ".digrc"
    ".hushlogin"
    ".local"
    ".profile"
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
echo "Next steps:"
echo "  1. Install Homebrew: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
echo "  2. Install packages: brew bundle --file=$DOTFILES_DIR/Brewfile"
echo "  3. Install Tmux Plugin Manager: git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm"
echo "  4. Reload shell: exec zsh"
