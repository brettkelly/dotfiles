#!/bin/bash
# Quick spot check for portable dotfiles on Linux (Ubuntu)

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}=== Dotfiles Remote Spot Check (Linux) ===${NC}\n"

# Track failures
FAILURES=0

check() {
    local test_name="$1"
    local command="$2"

    echo -n "Testing $test_name... "
    if eval "$command" &>/dev/null; then
        echo -e "${GREEN}✓${NC}"
    else
        echo -e "${RED}✗${NC}"
        ((FAILURES++))
    fi
}

# Test 1: Platform detection
echo -n "Platform detection... "
if [[ -f ~/.local/lib/platform.sh ]]; then
    source ~/.local/lib/platform.sh
    OS=$(detect_os)
    if [[ "$OS" == "linux" ]]; then
        echo -e "${GREEN}✓ (detected: linux)${NC}"
    else
        echo -e "${RED}✗ (detected: $OS)${NC}"
        ((FAILURES++))
    fi
else
    echo -e "${RED}✗ (platform.sh not found)${NC}"
    ((FAILURES++))
fi

# Test 2: Shell installed
check "zsh installed" "command -v zsh"

# Test 3: Core tools installed
check "git installed" "command -v git"
check "curl installed" "command -v curl"
check "wget installed" "command -v wget"

# Test 4: Modern CLI tools (if installed)
echo -e "\n${BLUE}Modern CLI tools (optional):${NC}"
check "neovim installed" "command -v nvim"
check "tmux installed" "command -v tmux"
check "fzf installed" "command -v fzf"
check "bat installed" "command -v bat || command -v batcat"
check "eza installed" "command -v eza"
check "ripgrep installed" "command -v rg"
check "fd installed" "command -v fd || command -v fdfind"

# Test 5: Zsh plugins (if installed)
echo -e "\n${BLUE}Zsh plugins (optional):${NC}"
check "Powerlevel10k" "[[ -d /usr/share/powerlevel10k ]]"
check "zsh-autosuggestions" "[[ -d /usr/share/zsh-autosuggestions ]]"
check "zsh-syntax-highlighting" "[[ -d /usr/share/zsh-syntax-highlighting ]]"

# Test 6: Dotfiles symlinks
echo -e "\n${BLUE}Dotfile symlinks:${NC}"
check ".zshrc linked" "[[ -L ~/.zshrc ]]"
check ".profile linked" "[[ -L ~/.profile ]]"
check ".tmux.conf linked" "[[ -L ~/.tmux.conf ]]"
check ".config linked" "[[ -L ~/.config ]]"

# Test 7: Shell loads
echo -e "\n${BLUE}Shell configuration:${NC}"
echo -n "Loading .zshrc... "
if zsh -c "source ~/.zshrc" 2>/dev/null; then
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${YELLOW}⚠ (may need plugins)${NC}"
fi

# Test 8: Version managers (if installed)
echo -e "\n${BLUE}Version managers (optional):${NC}"
check "pyenv directory" "[[ -d ~/.pyenv ]]"
check "nvm directory" "[[ -d ~/.nvm ]]"
check "rbenv directory" "[[ -d ~/.rbenv ]]"

# Summary
echo ""
echo -e "${BLUE}=== Summary ===${NC}"
if [[ $FAILURES -eq 0 ]]; then
    echo -e "${GREEN}All core checks passed! ✓${NC}"
    echo "Your dotfiles are working correctly on Linux."
    exit 0
else
    echo -e "${YELLOW}$FAILURES check(s) failed${NC}"
    echo "This may be expected if you haven't run install-tools.sh yet."
    echo ""
    echo "To complete installation:"
    echo "  1. Run: ~/dotfiles/install-tools.sh"
    echo "  2. Logout and login again (or run: exec zsh)"
    echo "  3. Run this test again"
    exit 1
fi
