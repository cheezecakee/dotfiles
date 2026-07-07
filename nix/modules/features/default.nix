{ self, inputs, ... }:
{
    flake.nixosModules.featuresMod = { pkgs, lib, self', config, ... }:
    {
        imports = [
            self.nixosModules.hyprlandMod
            self.nixosModules.appsMod
            self.nixosModules.cliMod
            self.nixosModules.sddmMod
        ];
    };
}
