{ self, inputs, ... }: {
    flake.nixosModules.myMachineConfiguration = { pkgs, lib, ... }: {
        networking.hostName = "desktop";

        secureboot.enable = true;
        gpu.type = "nvidia";

        system.stateVersion = "25.05";
    };
}
