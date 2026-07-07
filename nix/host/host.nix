{ hostConfig, ... }:

{

  imports = [
    # Hardware (you'll need to copy these from your old setup)
    ./hardware-configuration.nix
    
    # System modules
    ../system/audio.nix
    ../system/boot.nix
    ../system/cli.nix
    ../system/database.nix
    ../system/dev.nix
    # ../system/docker.nix
    ../system/editor.nix
    ../system/fonts.nix
    ../system/graphics.nix
    ../system/hyprland.nix
    ../system/libraries.nix
    ../system/network.nix
    ../system/region.nix
    ../system/sddm.nix
    ../system/settings.nix
    ../system/utils.nix
    ../system/apps.nix
    
    # User
    ../users/cheeze.nix
  ];

  networking.hostName = hostConfig.hostName;

  system.stateVersion = "25.05";
}

