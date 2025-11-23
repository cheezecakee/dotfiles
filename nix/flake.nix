{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.2";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.astal.follows = "astal";
    };
    
    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags-config = {
      url = "path:../.config/ags";
      flake = false;
    };

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
            ./ags.nix
        ];
    };
}
