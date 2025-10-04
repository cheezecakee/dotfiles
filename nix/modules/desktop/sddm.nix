{ config, pkgs, ... }:

{
  # SDDM configuration using Qt6
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm; # explicitly Qt6 version
    wayland.enable = true; # for Wayland sessions
    theme = "sddm-astronaut-theme";

    # Qt6 packages for theme dependencies
    extraPackages = with pkgs; [
      sddm-astronaut # the actual theme package
      kdePackages.qtmultimedia # required dependency
    ];
  };


  # System packages
  environment.systemPackages = with pkgs; [
    sddm-astronaut
    kdePackages.qtmultimedia
    kdePackages.qtbase
    kdePackages.qtwayland
    kdePackages.qtdeclarative
  ];
}
