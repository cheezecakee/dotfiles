{ self, inputs, ... }:
{
    flake.nixosModules.hardwareMod = { pkgs, lib, self', config, ... }:
    {
        imports = [
            self.nixosModules.myMachineHardware
            self.nixosModules.audioMod
            self.nixosModules.networkMod
            self.nixosModules.gpuMod
            self.nixosModules.storageMod
        ];

        environment.systemPackages = with pkgs; [
            brightnessctl
        ];   
    };
}
