mkdir -p "$HOME/.dotfiles/nix/modules/hosts/${HOSTNAME}"

envsubst '$HOSTNAME, $MACHINE, $GPU, $POWERMODE, $AUTOLOGIN, $SECUREBOOT' <"$HOME/.dotfiles/scripts/lib/config.template" >"$HOME/.dotfiles/nix/modules/hosts/${HOSTNAME}/configuration.nix"
echo "Config generated in $HOME/nix/modules/hosts/$HOSTNAME/configuration.nix"

envsubst '$HOSTNAME' <"$HOME/.dotfiles/scripts/lib/default.template" >"$HOME/.dotfiles/nix/modules/hosts/${HOSTNAME}/default.nix"
echo "Default generated in $HOME/nix/modules/hosts/$HOSTNAME/default.nix"

echo "Generating Hardware-configuration..."
export HARDWARECONFIG="$(nixos-generate-config --show-hardware-config 2>/dev/null | sed 's/^/    /')"

envsubst '$HARDWARECONFIG' <"$HOME/.dotfiles/scripts/lib/hardware.template" >"$HOME/.dotfiles/nix/modules/hardware/hardware.nix"
echo "Hardware-configuration generated in $HOME/nix/modules/hardware/hardware.nix"
