#!/usr/bin/env nix-shell
#!nix-shell -i bash -p envsubst

echo "Running with nix-shell environment"

envsubst '$HOSTNAME, $USERNAME, $MACHINE, $GPU, $POWERMODE, $AUTOLOGIN' < ./config.template > ../../nix/host/host.nix



