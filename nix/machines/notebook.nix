{ ... }:

{
  imports = [
    # Hardware
    ./hardware-configuration.nix
    # No drives.nix for notebook
    
    # System modules (same as desktop)
    ../system/audio.nix
    ../system/boot.nix
    ../system/cli.nix
    ../system/database.nix
    ../system/dev.nix
    ../system/docker.nix
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

  # Machine-specific hostname
  networking.hostName = "notebook";
  
  system.stateVersion = "25.05";
}
