{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Hypr
    hyprshot
    hyprpaper
    hyprshade
    hyprpanel

    # Wallpaper
    swww

    # Widgets
    eww

    waybar
    waybar-mpris

    rofi

    wlogout

    socat

    brightnessctl

    # Wifi manager
    impala

    # Audio
    mpdris2
    playerctl

    # JSON processor
    jq

    # Resource monitor
    btop
  ];
}
