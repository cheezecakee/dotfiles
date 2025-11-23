#!/usr/bin/env bash

# Get hostname argument or default to current hostname
MACHINE="${1:-$(machine)}"

cd ~/.dotfiles/nix || {
  notify-send -u critical "Build Error" "Failed to navigate to ~/.dotfiles/nix directory"
  exit 1
}

echo "[*] Rebuilding system for host: $MACHINE"
notify-send --replace-id=2000 "NixOS Rebuild" "Rebuilding $MACHINE configuration..."

if sudo -E nixos-rebuild switch --flake ".#$MACHINE"; then
  notify-send --replace-id=2000 "Build Complete" "System rebuild successful for $MACHINE!"
else
  notify-send -u critical --replace-id=2000 "Build Failed" "System rebuild failed for $MACHINE"
  exit 1
fi
