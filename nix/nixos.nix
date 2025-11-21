{ inputs, ... }: 
let
  configs = import ./config.nix;
in
{
  flake = {
    # Desktop
    nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.lanzaboote.nixosModules.lanzaboote
        ./machines/desktop.nix
      ];
      specialArgs = { 
        inherit inputs;
        machineConfig = configs.machines.desktop;
      };
    };
    
    # Notebook
    nixosConfigurations.notebook = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.lanzaboote.nixosModules.lanzaboote
        ./machines/notebook.nix
      ];
      specialArgs = { 
        inherit inputs;
        machineConfig = configs.machines.notebook;
      };
    };
  };
}
