{ self, inputs, ... }:
{
  flake.nixosModules.bootMod =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      config = {
        environment.systemPackages = lib.optionals config.secureboot.enable [ pkgs.sbctl ];

        # Bootloader
        boot = {
          loader = {
            grub.enable = false;
            systemd-boot.enable = !config.secureboot.enable; # Only if no secure boot
            efi.canTouchEfiVariables = true;
          };

          blacklistedKernelModules = [ "nouveau" ];

          # Only enable lanzaboote if secure boot is wanted
          lanzaboote = {
            enable = config.secureboot.enable;
            pkiBundle = "/var/lib/sbctl";
          };
        };
      };
    };
}
