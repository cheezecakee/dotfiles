{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    swww
    hyprshot
    hyprpaper
    hyprshade
    eww
    waybar
    waybar-mpris
    rofi

    wlogout

    socat

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
