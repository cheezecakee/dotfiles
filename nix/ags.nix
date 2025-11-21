{ inputs, ... }: {
  perSystem = { pkgs, system, ... }: {
    # Package for building AGS shell
    packages.my-shell = pkgs.stdenv.mkDerivation {
      pname = "my-shell";
      version = "0.1.0";
      
      src = ./ags;
      
      nativeBuildInputs = with pkgs; [
        wrapGAppsHook3
        gobject-introspection
        inputs.ags.packages.${system}.default
      ];
      
      buildInputs = with pkgs; [
        glib
        gjs
      ] ++ [
        inputs.astal.packages.${system}.io
        inputs.astal.packages.${system}.astal4
        inputs.astal.packages.${system}.battery
        inputs.astal.packages.${system}.network
      ];
      
      installPhase = ''
        mkdir -p $out/bin
        ${inputs.ags.packages.${system}.default}/bin/ags bundle app.ts $out/bin/my-shell
      '';
    };
    
    # Dev shell for AGS development
    devShells.ags = pkgs.mkShell {
      packages = with pkgs; [
        gtk4
        wrapGAppsHook3
        gobject-introspection
        glib
        gjs
      ] ++ [
        inputs.ags.packages.${system}.default
        inputs.astal.packages.${system}.io
        inputs.astal.packages.${system}.astal4
        inputs.astal.packages.${system}.notifd
        inputs.astal.packages.${system}.battery
        inputs.astal.packages.${system}.network
      ];
    };
  };
}
