#!/usr/bin/env bash

cd ~/nix/ || {
  notify-send -u critical "Build Error" "Failed to navigate to ~/nix/ directory"
  exit 1
}

# Use same ID (1000) to replace notifications instead of stacking
notify-send --replace-id=1000 "NixOS Update" "Starting flake update..."
echo "[*] Updating flake..."

if nix flake update; then
  notify-send --replace-id=1000 "NixOS Update" "Flake updated successfully. Starting rebuild..."
else
  notify-send -u critical --replace-id=1000 "Update Failed" "Flake update failed"
  exit 1
fi

echo "[*] Rebuilding system..."
notify-send --replace-id=1000 "NixOS Rebuild" "Rebuilding system configuration..."

if sudo -E nixos-rebuild switch --flake .#nixos; then
  notify-send --replace-id=1000 "Build Complete" "System rebuild successful!"
else
  notify-send -u critical --replace-id=1000 "Build Failed" "System rebuild failed"
  exit 1
fi
