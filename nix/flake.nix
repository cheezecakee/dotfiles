{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        flake-parts.url = "github:hercules-ci/flake-parts";
        import-tree.url = "github:denful/import-tree";

        lanzaboote.url = "github:nix-community/lanzaboote";

        dotfile-scripts = {
          url = "path:../scripts";
          flake = false;
        };
    };

    outputs = inputs @ { flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; }
    ({ systems = [ "x86_64-linux" ]; } // (inputs.import-tree ./modules));
}
