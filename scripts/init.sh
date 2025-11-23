#!/usr/bin/env bash

echo "[init]: $0"
echo "[machine]: ${1:-desktop}"    # optional default desktop
echo "[nvidia]: ${2:-false}"       # optional default false
echo "[secure boot]: ${3:-false}"  # optional default off

cd "$HOME" || exit 1

# Create symlink for nix
if [ ! -L nix ]; then
    echo "[init]: Creating symlink ~/nix -> ~/.dotfiles/nix"
    ln -s "$HOME/.dotfiles/nix" "$HOME/nix"
fi 

# Create symlink for .config
if [ ! -L .config ]; then
    echo "[init]: Creating symlink ~/.config -> ~/.dotfiles/.config"
    ln -s "$HOME/.dotfiles/.config" "$HOME/.config"
fi

# Copy and overwrite hardware-configuration.nix
DOTFILES_HARDWARE="$HOME/.dotfiles/nix/machines/hardware-configuration.nix"
SYSTEM_HARDWARE="/etc/nixos/hardware-configuration.nix"

if [ -f "$SYSTEM_HARDWARE" ]; then
    echo "[init]: Copying $SYSTEM_HARDWARE -> $DOTFILES_HARDWARE"
    cp -f "$SYSTEM_HARDWARE" "$DOTFILES_HARDWARE"
fi
