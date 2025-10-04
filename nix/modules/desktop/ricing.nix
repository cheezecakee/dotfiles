{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Wallpaper & Screenshots
    swww
    hyprshot
    hyprpaper
    hyprshade

    # Bars & Widgets
    eww
    waybar
    waybar-mpris

    # Launchers & Menus
    rofi
    wlogout

    # Utilities
    jq
    socat
    libnotify

    # Media Control
    mpdris2
    playerctl
  ];
}
