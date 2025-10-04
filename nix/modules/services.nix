{ config, pkgs, ... }:

{
  # Graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Auto mount USB drives
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Power management
  services.power-profiles-daemon.enable = true;

  # Remote desktop
  services.xrdp.enable = true;

  # SSH
  services.openssh.enable = true;

  # USB management utilities
  environment.systemPackages = with pkgs; [
    udisks2
    power-profiles-daemon
  ];
}
