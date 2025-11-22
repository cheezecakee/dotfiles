{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    gjs
    dart-sass
    gobject-introspection
    gtk-layer-shell
    gtk4
    gtk4-layer-shell
    # gtksourceview
    libadwaita
    libnotify
    libsoup_3
    wrapGAppsHook4
  ] ++ [
    inputs.ags.packages.${pkgs.system}.default
    inputs.astal.packages.${pkgs.system}.astal4
    inputs.astal.packages.${pkgs.system}.battery
    inputs.astal.packages.${pkgs.system}.hyprland
    inputs.astal.packages.${pkgs.system}.io
    inputs.astal.packages.${pkgs.system}.mpris
    inputs.astal.packages.${pkgs.system}.network
    inputs.astal.packages.${pkgs.system}.notifd
  ];
}
