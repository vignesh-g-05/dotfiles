#!/usr/bin/env bash
set -euo pipefail

echo "Setting up your Linux environment..."

# Detect package manager
if command -v apt &>/dev/null; then
    PKG_INSTALL="sudo apt install -y"
    UPDATE_CMD="sudo apt update"
elif command -v dnf &>/dev/null; then
    PKG_INSTALL="sudo dnf install -y"
    UPDATE_CMD="sudo dnf update -y"
elif command -v pacman &>/dev/null; then
    PKG_INSTALL="sudo pacman -S --noconfirm"
    UPDATE_CMD="sudo pacman -Syu --noconfirm"
else
    echo "No supported package manager found!"
    exit 1
fi

# Update system
$UPDATE_CMD

# Base tools
echo "Installing base tools..."
$PKG_INSTALL git curl wget zsh stow unzip

# Developer tools
echo "Installing developer tools..."
$PKG_INSTALL neovim nodejs npm

# Terminal tools
$PKG_INSTALL bat eza fzf ripgrep fd-find fastfetch

# Optional utilities
$PKG_INSTALL zoxide tmux trash-cli

# Fix command naming differences
mkdir -p ~/.local/bin
if command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
    ln -sf "$(command -v fdfind)" ~/.local/bin/fd
fi
if command -v batcat &>/dev/null && ! command -v bat &>/dev/null; then
    ln -sf "$(command -v batcat)" ~/.local/bin/bat
fi

# Install NVM
if [ ! -d "$HOME/.nvm" ]; then
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
fi

# Install Starship
if ! command -v starship &>/dev/null; then
    echo "Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

# Install Atuin
if ! command -v atuin &>/dev/null; then
    echo "Installing Atuin..."
    curl -s https://raw.githubusercontent.com/atuinsh/atuin/main/install.sh | bash -s -- --yes
fi

# Install fonts
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

# JetBrains Mono
if [ ! -f "$FONT_DIR/JetBrainsMono-Regular.ttf" ]; then
    echo "Installing JetBrains Mono..."
    wget -q https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip -O /tmp/JetBrainsMono.zip
    unzip -o /tmp/JetBrainsMono.zip "*.ttf" -d "$FONT_DIR" >/dev/null
    rm /tmp/JetBrainsMono.zip
fi

# JetBrains Mono Nerd Font
if [ ! -f "$FONT_DIR/JetBrains Mono Regular Nerd Font Complete.ttf" ]; then
    echo "Installing JetBrains Mono Nerd Font..."
    wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip -O /tmp/JetBrainsMonoNerd.zip
    unzip -o /tmp/JetBrainsMonoNerd.zip "*.ttf" -d "$FONT_DIR" >/dev/null
    rm /tmp/JetBrainsMonoNerd.zip
fi

fc-cache -f > /dev/null
echo "Font cache refreshed."

# Set Zsh as default
if [ "$SHELL" != "$(command -v zsh)" ]; then
    echo "Setting Zsh as default shell..."
    chsh -s "$(command -v zsh)"
fi

# Stow dotfiles
if [ -d "$HOME/.dotfiles" ]; then
    echo "Linking dotfiles..."
    cd "$HOME/.dotfiles"
    stow -v --restow */
else
    echo "No ~/.dotfiles directory found — skipping stow."
fi

echo "✅ Setup complete!"
