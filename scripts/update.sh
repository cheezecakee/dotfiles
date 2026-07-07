#!/usr/bin/env bash

# Get hostname argument or default to current hostname
MACHINE="${1:-$(hostname)}"

cd ~/.dotfiles/nix || {
  notify-send -u critical "Build Error" "Failed to navigate to ~/.dotfiles/nix directory"
  exit 1
}

notify-send --replace-id=1000 "NixOS Update" "Starting flake update..."
echo "[*] Updating flake..."

if nix flake update; then
  notify-send --replace-id=1000 "NixOS Update" "Flake updated. Rebuilding $MACHINE..."
else
  notify-send -u critical --replace-id=1000 "Update Failed" "Flake update failed"
  exit 1
fi

echo "[*] Rebuilding system for host: $MACHINE"
notify-send --replace-id=1000 "NixOS Rebuild" "Rebuilding $MACHINE configuration..."

if sudo nixos-rebuild switch --upgrade --flake ".#$MACHINE"; then
  notify-send --replace-id=1000 "Build Complete" "System rebuild successful for $MACHINE!"
else
  notify-send -u critical --replace-id=1000 "Build Failed" "System rebuild failed for $MACHINE"
  exit 1
fi
