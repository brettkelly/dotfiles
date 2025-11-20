#!/usr/bin/env bash
# Platform detection and utility functions for portable dotfiles

# Detect operating system
detect_os() {
    case "$(uname -s)" in
        Darwin*)
            echo "macos"
            ;;
        Linux*)
            echo "linux"
            ;;
        *)
            echo "unknown"
            ;;
    esac
}

# Detect Linux distribution
detect_linux_distro() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        echo "$ID"
    else
        echo "unknown"
    fi
}

# Detect package manager
detect_package_manager() {
    local os=$(detect_os)

    if [[ "$os" == "macos" ]]; then
        echo "brew"
    elif [[ "$os" == "linux" ]]; then
        if command -v apt-get &> /dev/null; then
            echo "apt"
        elif command -v dnf &> /dev/null; then
            echo "dnf"
        elif command -v yum &> /dev/null; then
            echo "yum"
        elif command -v pacman &> /dev/null; then
            echo "pacman"
        else
            echo "unknown"
        fi
    else
        echo "unknown"
    fi
}

# Find a command in multiple possible locations
find_command() {
    local cmd="$1"
    command -v "$cmd" 2>/dev/null
}

# Find Homebrew prefix (macOS)
find_brew_prefix() {
    if command -v brew &> /dev/null; then
        brew --prefix
    elif [[ -d "/opt/homebrew" ]]; then
        echo "/opt/homebrew"
    elif [[ -d "/usr/local" ]]; then
        echo "/usr/local"
    fi
}

# Find zsh plugin path
find_zsh_plugin() {
    local plugin="$1"
    local brew_prefix=$(find_brew_prefix)

    # Check Homebrew locations first (macOS)
    if [[ -n "$brew_prefix" ]]; then
        if [[ -f "$brew_prefix/share/$plugin/$plugin.zsh" ]]; then
            echo "$brew_prefix/share/$plugin/$plugin.zsh"
            return 0
        fi
    fi

    # Check common Linux locations
    local locations=(
        "/usr/share/$plugin/$plugin.zsh"
        "/usr/local/share/$plugin/$plugin.zsh"
        "$HOME/.local/share/$plugin/$plugin.zsh"
        "/usr/share/zsh/plugins/$plugin/$plugin.zsh"
        "/usr/share/zsh-$plugin/$plugin.zsh"
    )

    for loc in "${locations[@]}"; do
        if [[ -f "$loc" ]]; then
            echo "$loc"
            return 0
        fi
    done

    return 1
}

# Find powerlevel10k theme
find_p10k_theme() {
    local brew_prefix=$(find_brew_prefix)

    # Check Homebrew location (macOS)
    if [[ -n "$brew_prefix" && -f "$brew_prefix/share/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
        echo "$brew_prefix/share/powerlevel10k/powerlevel10k.zsh-theme"
        return 0
    fi

    # Check common Linux locations
    local locations=(
        "/usr/share/powerlevel10k/powerlevel10k.zsh-theme"
        "/usr/local/share/powerlevel10k/powerlevel10k.zsh-theme"
        "$HOME/.local/share/powerlevel10k/powerlevel10k.zsh-theme"
        "/usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme"
    )

    for loc in "${locations[@]}"; do
        if [[ -f "$loc" ]]; then
            echo "$loc"
            return 0
        fi
    done

    return 1
}

# Check if running on macOS
is_macos() {
    [[ "$(detect_os)" == "macos" ]]
}

# Check if running on Linux
is_linux() {
    [[ "$(detect_os)" == "linux" ]]
}

# Check if a command exists
has_command() {
    command -v "$1" &> /dev/null
}

# Get architecture
get_arch() {
    uname -m
}

# Check if Apple Silicon
is_apple_silicon() {
    [[ "$(detect_os)" == "macos" ]] && [[ "$(get_arch)" == "arm64" ]]
}
