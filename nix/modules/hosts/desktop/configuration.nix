# DO NOT TOUCH THIS FILE
{ self, inputs, ... }: {
  flake.nixosModules.desktopConfiguration = { pkgs, lib, ... }: {
    networking.hostName = "desktop";

    machine.type = "desktop";

    secureboot.enable = true;

    gpu.type = "nvidia";

    powerMode.type = "perfomance";

    autoLogin.enable = true;

    system.stateVersion = "25.05";
  };
}
