# Linux-specific shell configuration
# Sourced by .zshrc when running on Linux

# ---- Linux-specific aliases ----
# bat is installed as batcat on Ubuntu
if command -v batcat &> /dev/null && ! command -v bat &> /dev/null; then
    alias bat='batcat'
fi

# fd is installed as fdfind on Ubuntu
if command -v fdfind &> /dev/null && ! command -v fd &> /dev/null; then
    alias fd='fdfind'
fi

# ---- Linux-specific environment variables ----
# Add any Linux-specific environment variables here

# ---- Linux package manager aliases ----
alias update='sudo apt-get update && sudo apt-get upgrade'
alias install='sudo apt-get install'
alias remove='sudo apt-get remove'
alias search='apt-cache search'

# ---- Clipboard aliases (xclip/xsel) ----
if command -v xclip &> /dev/null; then
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
elif command -v xsel &> /dev/null; then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
fi

# ---- Display/X11 configuration ----
# Set DISPLAY if not already set (useful for WSL)
if [[ -z "$DISPLAY" ]] && [[ -n "$WSL_DISTRO_NAME" ]]; then
    export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
fi

# ---- Linux-specific PATH additions ----
# Add local bin if not already in PATH
[[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && export PATH="$HOME/.local/bin:$PATH"

# Add cargo (Rust) to PATH if installed
if [[ -d "$HOME/.cargo/bin" ]]; then
    [[ ":$PATH:" != *":$HOME/.cargo/bin:"* ]] && export PATH="$HOME/.cargo/bin:$PATH"
fi

# ---- Systemd aliases (if systemd is available) ----
if command -v systemctl &> /dev/null; then
    alias sc='sudo systemctl'
    alias scs='systemctl status'
    alias scr='sudo systemctl restart'
    alias sce='sudo systemctl enable'
    alias scd='sudo systemctl disable'
fi

# ---- Docker (if installed) ----
if command -v docker &> /dev/null; then
    # Add user to docker group commands if not already in docker group
    if ! groups | grep -q docker; then
        alias docker='sudo docker'
        alias docker-compose='sudo docker-compose'
    fi
fi

# ---- SSH Agent ----
# Start SSH agent if not already running
if [[ -z "$SSH_AUTH_SOCK" ]] && command -v ssh-agent &> /dev/null; then
    eval "$(ssh-agent -s)" > /dev/null
fi
