{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Hypr
    hyprshot
    hyprpaper
    hyprshade
    hyprpanel

    # Wallpaper
    awww

    # Widgets
    eww
    noctalia-shell

    waybar
    waybar-mpris

    rofi

    wlogout

    socat

    brightnessctl

    # Audio
    mpdris2
    playerctl

    # JSON processor
    jq

    # Resource monitor
    btop

  ];
}
