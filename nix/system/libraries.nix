{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    dart-sass
    gobject-introspection
    gtk-layer-shell
    gtk4
    gtk4-layer-shell
    # gtksourceview
    libadwaita
    libnotify
    libsoup_3
  ];
}
