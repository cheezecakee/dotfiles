#!/usr/bin/env nix-shell
#!nix-shell -i bash -p jq envsubst bat

import HOSTNAME
echo "Running with nix-shell environment"
bat --version

read -r "READ"
echo "$READ"
