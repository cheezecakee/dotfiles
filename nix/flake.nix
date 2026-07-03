{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    lanzaboote.url = "github:nix-community/lanzaboote";

    dotfile-scripts = {
      url = "path:../scripts";
      flake = false;
    };
  };

  outputs = inputs @ { flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs;}
    {
        systems = [ "x86_64-linux" ];

        imports = [
            ./nixos.nix
            ./package.nix
            ./shell.nix
            ./scripts.nix
        ];
    };
}
