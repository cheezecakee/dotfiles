{ pkgs, lib, machineConfig, ... }:

## Need two options here 
{
  environment.systemPackages = lib.optionals machineConfig.hasSecureBoot [ pkgs.sbctl ];

  # Bootloader
  boot.loader = {
    grub.enable = false;
    systemd-boot.enable = !machineConfig.hasSecureBoot; #Only if no secure boot
    efi.canTouchEfiVariables = true;
  };

  boot.blacklistedKernelModules = [ "nouveau" ];

  # Only enable lanzaboote if secure boot is wanted
  boot.lanzaboote = lib.mkIf machineConfig.hasSecureBoot {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
}

