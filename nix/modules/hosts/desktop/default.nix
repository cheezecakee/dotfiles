{ self, inputs, ... }:
{
    flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
        modules = [
            inputs.lanzaboote.nixosModules.lanzaboote
            self.nixosModules.hardwareMod
            self.nixosModules.myMachineConfiguration
            self.nixosModules.systemMod
            self.nixosModules.featuresMod
            self.nixosModules.userMod
        ];
    };
}
