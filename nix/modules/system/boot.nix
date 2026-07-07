{ self, inputs, ... }:
## Need two options here 
{
    flake.nixosModules.bootMod = { pkgs, lib, config, ... }: 
    {
        options = {
            secureboot.enable = lib.mkEnableOption "secure boot via lanzaboote";
        };

        config = {
            environment.systemPackages = lib.optionals config.secureboot.enable [ pkgs.sbctl ];

            # Bootloader
            boot.loader = {
                grub.enable = false;
                systemd-boot.enable = !config.secureboot.enable; #Only if no secure boot
                efi.canTouchEfiVariables = true;
            };

            boot.blacklistedKernelModules = [ "nouveau" ];

            # Only enable lanzaboote if secure boot is wanted
            boot.lanzaboote = {
                enable = config.secureboot.enable;
                pkiBundle = "/var/lib/sbctl";
            };
        };
    }; 
}

