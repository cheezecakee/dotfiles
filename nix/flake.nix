
{
  description = "Modular NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    lanzaboote.url  = "github:nix-community/lanzaboote/v0.4.2";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = { self, nixpkgs, lanzaboote, flake-utils, zen-browser, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        lanzaboote.nixosModules.lanzaboote
        ./hosts/desktop/default.nix
      ];

      specialArgs = {
        zen-browser = zen-browser;
      };
    };
  };
}

