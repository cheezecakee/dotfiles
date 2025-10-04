#!/usr/bin/env bash

cd ~/nix/ || {
  notify-send -u critical "Build Error" "Failed to navigate to ~/nix directory"
  exit 1
}

echo "[*] Rebuilding system..."
notify-send --replace-id=2000 "NixOS Rebuild" "Rebuilding system configuration..."

if sudo -E nixos-rebuild switch --flake .#nixos; then
  notify-send --replace-id=2000 "Build Complete" "System rebuild successful!"
else
  notify-send -u critical --replace-id=2000 "Build Failed" "System rebuild failed"
  exit 1
fi
