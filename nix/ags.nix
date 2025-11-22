{ inputs, ... }: {
  perSystem = { pkgs, system, ... }: {
    packages.ags-widgets = pkgs.stdenv.mkDerivation {
      pname = "ags-widgets";
      version = "0.1.0";

      src = inputs.ags-config;

      dontUnpack = true;
      dontPatch = true;

      nativeBuildInputs = with pkgs; [
        wrapGAppsHook4
        gobject-introspection
        inputs.ags.packages.${system}.default
      ];

      buildInputs =
        (with pkgs; [
          gjs
          glib
          gtk-layer-shell
          gtk4
          gtk4-layer-shell
          libadwaita
          libnotify
          libsoup_3
        ]) ++ [
          inputs.astal.packages.${system}.astal4
          inputs.astal.packages.${system}.battery
          inputs.astal.packages.${system}.hyprland
          inputs.astal.packages.${system}.io
          inputs.astal.packages.${system}.mpris
          inputs.astal.packages.${system}.network
          inputs.astal.packages.${system}.notifd
        ];

      installPhase = ''
        mkdir -p $out/bin
        cd $src
        ${inputs.ags.packages.${system}.default}/bin/ags \
          bundle app.tsx $out/bin/ags-widgets
      '';


        preFixup = ''
          gappsWrapperArgs+=(
            --prefix PATH "" ${pkgs.lib.makeBinPath [
              pkgs.gjs
              pkgs.glib
              pkgs.gtk-layer-shell
              pkgs.gtk4
              pkgs.gtk4-layer-shell
              pkgs.libadwaita
              pkgs.libnotify
              pkgs.libsoup_3
            ]}
          )
        '';
    };

    devShells.ags = pkgs.mkShell {
      packages =
        (with pkgs; [
          gjs
          glib
          gobject-introspection
          gtk-layer-shell
          gtk4
          gtk4-layer-shell
          libadwaita
          libnotify
          libsoup_3
          wrapGAppsHook4
        ]) ++ [
          inputs.ags.packages.${system}.default
          inputs.astal.packages.${system}.astal4
          inputs.astal.packages.${system}.battery
          inputs.astal.packages.${system}.hyprland
          inputs.astal.packages.${system}.io
          inputs.astal.packages.${system}.mpris
          inputs.astal.packages.${system}.network
          inputs.astal.packages.${system}.notifd
        ];
    };
  };
}

