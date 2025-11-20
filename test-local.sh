#!/bin/bash
# Quick spot check for portable dotfiles on macOS

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}=== Dotfiles Local Spot Check ===${NC}\n"

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

# Test 1: Shell config loads without errors
echo -n "Loading .zshrc... "
if zsh -c "source ~/.zshrc" &>/dev/null; then
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${RED}✗${NC}"
    ((FAILURES++))
fi

# Test 2: Platform detection works
echo -n "Platform detection... "
if zsh -c "source ~/.local/lib/platform.sh && [[ \$(detect_os) == 'macos' ]]"; then
    echo -e "${GREEN}✓ (detected: macos)${NC}"
else
    echo -e "${RED}✗${NC}"
    ((FAILURES++))
fi

# Test 3: Homebrew prefix found
echo -n "Homebrew prefix detection... "
BREW_PREFIX=$(zsh -c "source ~/.local/lib/platform.sh && find_brew_prefix" 2>/dev/null)
if [[ -n "$BREW_PREFIX" ]]; then
    echo -e "${GREEN}✓ ($BREW_PREFIX)${NC}"
else
    echo -e "${RED}✗${NC}"
    ((FAILURES++))
fi

# Test 4: Zsh plugins detected
echo -n "Powerlevel10k theme... "
P10K_PATH=$(zsh -c "source ~/.local/lib/platform.sh && find_p10k_theme" 2>/dev/null)
if [[ -n "$P10K_PATH" && -f "$P10K_PATH" ]]; then
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${RED}✗${NC}"
    ((FAILURES++))
fi

echo -n "zsh-autosuggestions... "
PLUGIN_PATH=$(zsh -c "source ~/.local/lib/platform.sh && find_zsh_plugin 'zsh-autosuggestions'" 2>/dev/null)
if [[ -n "$PLUGIN_PATH" && -f "$PLUGIN_PATH" ]]; then
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${RED}✗${NC}"
    ((FAILURES++))
fi

# Test 5: Key tools are in PATH
check "zsh in PATH" "command -v zsh"
check "nvim in PATH" "command -v nvim"
check "tmux in PATH" "command -v tmux"
check "git in PATH" "command -v git"

# Test 6: Version managers
check "pyenv available" "command -v pyenv"
check "nvm directory exists" "[[ -d ~/.nvm ]]"

# Test 7: Neovim config
echo -n "Neovim config exists... "
if [[ -f ~/.config/nvim/init.lua ]]; then
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${RED}✗${NC}"
    ((FAILURES++))
fi

# Test 8: Neovim loads without errors
echo -n "Neovim loads... "
if nvim --headless -c "quit" 2>/dev/null; then
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${YELLOW}⚠ (might need plugin sync)${NC}"
fi

# Test 9: Tmux config
echo -n "Tmux config exists... "
if [[ -f ~/.tmux.conf ]]; then
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${RED}✗${NC}"
    ((FAILURES++))
fi

# Test 10: Custom scripts accessible
echo -n "Custom scripts in PATH... "
if [[ -d ~/.local/bin ]] && [[ ":$PATH:" == *":$HOME/.local/bin:"* ]]; then
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${RED}✗${NC}"
    ((FAILURES++))
fi

# Summary
echo ""
echo -e "${BLUE}=== Summary ===${NC}"
if [[ $FAILURES -eq 0 ]]; then
    echo -e "${GREEN}All checks passed! ✓${NC}"
    echo "Your dotfiles are working correctly on macOS."
    exit 0
else
    echo -e "${RED}$FAILURES check(s) failed ✗${NC}"
    echo "Please review the failures above."
    exit 1
fi
