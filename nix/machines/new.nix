{ ... }:

{

  imports = [
    # Hardware (this setup is usually ran with a script that will replace this hardware-configuration config with your current one)
    ./hardware-configuration.nix
    
    # System modules
    ../system/audio.nix
    ../system/boot.nix
    ../system/cli.nix
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
    ../users/new.nix #Update this with your user preferences
  ];

  networking.hostName = "new";

  system.stateVersion = "25.05";
}
