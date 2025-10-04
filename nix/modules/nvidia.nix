{ config, pkgs, lib, ... }:

{
  # Nvidia graphics setup
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement = {
      enable = false;
      finegrained = false;
    };

    open = false;

    nvidiaSettings = true;

    nvidiaPersistenced = true;

    dynamicBoost.enable = false;

    prime = {
      sync.enable = true;
      nvidiaBusId = "PCI:14:0:0";
      intelBusId = "PCI:0:2:0"; #For INTEL GPU
      #  amdgpuBusId = "PCI:54:0:0}"; #For AMD GPU
    };

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  hardware.nvidia-container-toolkit.enable = true;
}
