{ inputs, self, ... }:
{
  flake.nixosModules.hyprlandMod = { pkgs, ... }: {
    # Enable Wayland and Hyprland
    programs.hyprland = {
      enable = true;
      withUWSM = true; # recommended for most users
      xwayland.enable = true; # xwayland can be disabled.
    };

    programs.uwsm.enable = true;

    # Display manager configuration (theme config moved to themes.nix)
    services.displayManager = {
      # SDDM configuration is now handled in themes.nix
      defaultSession = "hyprland-uwsm";
    };

    # Enable xdg portal for screen capture from Wayland
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk # Fallback for some applications
      ];
      config.common.default = "*";
      config.hyprland.default = [
        "hyprland"
        "gtk"
      ];
    };

    # Wayland utilities and hypr packages
    environment.systemPackages = with pkgs; [
      wl-clipboard
      wf-recorder

      # TODO will be removed
      waybar

      hyprshot
      hyprpaper
      hyprshade

      # Widgets
      noctalia-shell
      rofi
      wlogout
    ];
  };
}
