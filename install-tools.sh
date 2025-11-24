#!/usr/bin/env bash
# Cross-platform tool installation script for dotfiles
# Supports macOS (Homebrew) and Ubuntu (apt)

set -e

# Source platform detection utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/.local/lib/platform.sh"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print functions
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running as root
check_root() {
    if [[ $EUID -eq 0 ]]; then
        print_error "This script should not be run as root (except for package installation steps which will use sudo)"
        exit 1
    fi
}

# Install Homebrew on macOS
install_homebrew() {
    if ! has_command brew; then
        print_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Add Homebrew to PATH for this session
        if [[ -f "/opt/homebrew/bin/brew" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [[ -f "/usr/local/bin/brew" ]]; then
            eval "$(/usr/local/bin/brew shellenv)"
        fi

        print_success "Homebrew installed successfully"
    else
        print_info "Homebrew already installed"
    fi
}

# Install packages on macOS using Homebrew
install_macos_packages() {
    print_info "Installing packages on macOS using Homebrew..."

    install_homebrew

    if [[ -f "$SCRIPT_DIR/Brewfile" ]]; then
        print_info "Installing from Brewfile..."
        brew bundle --file="$SCRIPT_DIR/Brewfile"
        print_success "Homebrew packages installed"
    else
        print_warning "Brewfile not found, installing core packages manually..."
        brew install git zsh neovim tmux fzf bat eza zoxide ripgrep fd \
                     python node ruby gh lazygit
    fi
}

# Update apt and install prerequisites on Ubuntu
setup_ubuntu_repos() {
    print_info "Updating apt and installing prerequisites..."
    sudo apt-get update
    sudo apt-get install -y software-properties-common apt-transport-https \
                            ca-certificates gnupg curl wget build-essential
}

# Install Neovim on Ubuntu (latest stable from PPA)
install_neovim_ubuntu() {
    if ! has_command nvim; then
        print_info "Installing Neovim..."
        sudo add-apt-repository -y ppa:neovim-ppa/unstable
        sudo apt-get update
        sudo apt-get install -y neovim
        print_success "Neovim installed"
    else
        print_info "Neovim already installed"
    fi
}

# Install latest tmux on Ubuntu
install_tmux_ubuntu() {
    if ! has_command tmux; then
        print_info "Installing tmux..."
        sudo apt-get install -y tmux
        print_success "tmux installed"
    else
        print_info "tmux already installed"
    fi
}

# Install zsh and set as default shell
install_zsh_ubuntu() {
    if ! has_command zsh; then
        print_info "Installing zsh..."
        sudo apt-get install -y zsh
        print_success "zsh installed"
    else
        print_info "zsh already installed"
    fi

    # Set zsh as default shell if not already
    if [[ "$SHELL" != *"zsh"* ]]; then
        print_info "Setting zsh as default shell..."
        chsh -s "$(which zsh)"
        print_success "zsh set as default shell (will take effect on next login)"
    fi
}

# Install zsh plugins on Ubuntu
install_zsh_plugins_ubuntu() {
    print_info "Installing zsh plugins..."

    # powerlevel10k
    if [[ ! -d /usr/share/powerlevel10k ]]; then
        print_info "Installing powerlevel10k..."
        sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /usr/share/powerlevel10k
        print_success "powerlevel10k installed"
    fi

    # zsh-autosuggestions
    if [[ ! -d /usr/share/zsh-autosuggestions ]]; then
        print_info "Installing zsh-autosuggestions..."
        sudo git clone https://github.com/zsh-users/zsh-autosuggestions /usr/share/zsh-autosuggestions
        print_success "zsh-autosuggestions installed"
    fi

    # zsh-syntax-highlighting
    if [[ ! -d /usr/share/zsh-syntax-highlighting ]]; then
        print_info "Installing zsh-syntax-highlighting..."
        sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /usr/share/zsh-syntax-highlighting
        print_success "zsh-syntax-highlighting installed"
    fi
}

# Install modern CLI tools on Ubuntu
install_modern_cli_tools_ubuntu() {
    print_info "Installing modern CLI tools..."

    # fzf
    if ! has_command fzf; then
        sudo apt-get install -y fzf
    fi

    # yazi
    if ! has_command yazi; then
        sudo apt-get install -y yazi
    fi

    # bat (batcat on Ubuntu)
    if ! has_command bat && ! has_command batcat; then
        sudo apt-get install -y bat
        # Create symlink if it's installed as batcat
        if [[ -f /usr/bin/batcat && ! -f /usr/local/bin/bat ]]; then
            sudo ln -s /usr/bin/batcat /usr/local/bin/bat
        fi
    fi

    # eza (modern ls replacement)
    if ! has_command eza; then
        sudo mkdir -p /etc/apt/keyrings
        wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
        echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
        sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
        sudo apt-get update
        sudo apt-get install -y eza
    fi

    # ripgrep
    if ! has_command rg; then
        sudo apt-get install -y ripgrep
    fi

    # fd-find
    if ! has_command fd; then
        sudo apt-get install -y fd-find
        # Create symlink
        if [[ -f /usr/bin/fdfind && ! -f /usr/local/bin/fd ]]; then
            sudo ln -s /usr/bin/fdfind /usr/local/bin/fd
        fi
    fi

    # zoxide
    if ! has_command zoxide; then
        curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    fi

    print_success "Modern CLI tools installed"
}

# Install development tools on Ubuntu
install_dev_tools_ubuntu() {
    print_info "Installing development tools..."

    # Git
    sudo apt-get install -y git

    # Build essentials
    sudo apt-get install -y build-essential

    # GitHub CLI
    if ! has_command gh; then
        curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
        sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
        sudo apt-get update
        sudo apt-get install -y gh
    fi

    # lazygit (Git TUI)
    if ! has_command lazygit; then
        LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
        curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
        tar xf lazygit.tar.gz lazygit
        sudo install lazygit /usr/local/bin
        rm lazygit lazygit.tar.gz
        print_success "lazygit installed"
    fi

    # tree (directory visualization)
    if ! has_command tree; then
        sudo apt-get install -y tree
    fi

    # jq (JSON processor)
    if ! has_command jq; then
        sudo apt-get install -y jq
    fi

    # htop (process viewer)
    if ! has_command htop; then
        sudo apt-get install -y htop
    fi

    print_success "Development tools installed"
}

# Install language version managers on Ubuntu
install_version_managers_ubuntu() {
    print_info "Installing language version managers..."

    # pyenv
    if [[ ! -d "$HOME/.pyenv" ]]; then
        print_info "Installing pyenv..."
        sudo apt-get install -y libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
                                libsqlite3-dev llvm libncursesw5-dev xz-utils \
                                tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
        curl https://pyenv.run | bash
        print_success "pyenv installed"
    fi

    # nvm (Node Version Manager)
    if [[ ! -d "$HOME/.nvm" ]]; then
        print_info "Installing nvm..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
        print_success "nvm installed"
    fi

    # rbenv
    if [[ ! -d "$HOME/.rbenv" ]]; then
        print_info "Installing rbenv..."
        sudo apt-get install -y libssl-dev libreadline-dev zlib1g-dev
        git clone https://github.com/rbenv/rbenv.git ~/.rbenv
        git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
        print_success "rbenv installed"
    fi

    print_success "Version managers installed"
}

# Install packages on Ubuntu
install_ubuntu_packages() {
    print_info "Installing packages on Ubuntu..."

    setup_ubuntu_repos
    install_zsh_ubuntu
    install_zsh_plugins_ubuntu
    install_neovim_ubuntu
    install_tmux_ubuntu
    install_modern_cli_tools_ubuntu
    install_dev_tools_ubuntu
    install_version_managers_ubuntu

    print_success "All Ubuntu packages installed"
}

# Main installation function
main() {
    print_info "Dotfiles Tool Installation Script"
    print_info "=================================="

    check_root

    local os=$(detect_os)
    print_info "Detected OS: $os"

    case "$os" in
        macos)
            install_macos_packages
            ;;
        linux)
            local distro=$(detect_linux_distro)
            print_info "Detected Linux distribution: $distro"

            if [[ "$distro" == "ubuntu" ]] || [[ "$distro" == "debian" ]]; then
                install_ubuntu_packages
            else
                print_error "Unsupported Linux distribution: $distro"
                print_info "This script currently only supports Ubuntu/Debian"
                exit 1
            fi
            ;;
        *)
            print_error "Unsupported operating system"
            exit 1
            ;;
    esac

    print_success "Installation complete!"
    print_info "Please restart your shell or run: source ~/.zshrc"
}

# Run main function
main "$@"
