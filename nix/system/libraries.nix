{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    gtk4
    gtk-layer-shell
    gobject-introspection
    dart-sass
    wrapGAppsHook3

    libnotify
  ] ++ [
    inputs.ags.packages.${pkgs.system}.default

    inputs.astal.packages.${pkgs.system}.io
    inputs.astal.packages.${pkgs.system}.astal4
    inputs.astal.packages.${pkgs.system}.notifd
    inputs.astal.packages.${pkgs.system}.battery
    inputs.astal.packages.${pkgs.system}.network
  ];
}
