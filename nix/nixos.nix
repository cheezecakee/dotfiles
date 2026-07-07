{ inputs, ... }: 
let
  configs = import ./config.nix;
in
{
  flake = {
    # Desktop
    nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
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
      modules = [
        inputs.lanzaboote.nixosModules.lanzaboote
        ./machines/notebook.nix
      ];
      specialArgs = { 
        inherit inputs;
        machineConfig = configs.machines.notebook;
      };
    };

    # New
    nixosConfigurations.new = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        inputs.lanzaboote.nixosModules.lanzaboote
        ./machines/notebook.nix
      ];
      specialArgs = { 
        inherit inputs;
        machineConfig = configs.machines.new;
      };
    };
  };
}

# { inputs, ... }: 
#
# let
#   configs = import ./config.nix;
# in
# {
#   flake = {
#     # Desktop
#     nixosConfigurations.host = inputs.nixpkgs.lib.nixosSystem {
#       modules = [
#         inputs.lanzaboote.nixosModules.lanzaboote
#         ./host/host.nix
#         ./host/storage.nix
#       ];
#       specialArgs = { 
#         inherit inputs;
#         machineConfig = configs.host;
#       };
#     };
#   };
# }

