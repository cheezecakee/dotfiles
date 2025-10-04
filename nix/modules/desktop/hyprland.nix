{ config, pkgs, ... }:

{
  # Enable Wayland and Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true; # recommended for most users
    xwayland.enable = true; # xwayland can be disabled.
  };

  programs.uwsm.enable = true;

  # Enable X server 
  services.xserver.enable = true;

  # Display manager configuration (theme config moved to themes.nix)
  services.displayManager = {
    # SDDM configuration is now handled in themes.nix
    defaultSession = "hyprland-uwsm";
  };

  # Enable elogind for session management
  services.dbus.enable = true;

  # Enable xdg portal for screen capture from Wayland
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk # Fallback for some applications
    ];
    config.common.default = "*";
    config.hyprland.default = [ "hyprland" "gtk" ];
  };

 # Wayland utilities
  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];
}

