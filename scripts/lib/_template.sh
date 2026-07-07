echo "Running with nix-shell environment"

envsubst '$HOSTNAME, $USERNAME, $MACHINE, $GPU, $POWERMODE, $AUTOLOGIN, $SECUREBOOT' < $HOME/.dotfiles/scripts/lib/config.template > $HOME/.dotfiles/nix/config.nix
