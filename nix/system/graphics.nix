{ config, pkgs, lib, machineConfig, ... }:

{
  # Basic graphics always enabled
  hardware.graphics.enable = true;
  
  # Nvidia-specific config - only if hasNvidia
  services.xserver.videoDrivers = lib.mkIf machineConfig.hasNvidia [ "nvidia" ];
  
  hardware.nvidia = lib.mkIf machineConfig.hasNvidia {
    modesetting.enable = true;

    powerManagement = {
      enable = false;
      finegrained = false;
    };

    open = false;
    nvidiaSettings = true;
    nvidiaPersistenced = false;
    dynamicBoost.enable = false;

    prime = {
      sync.enable = true;
      nvidiaBusId = "PCI:14:0:0";
      intelBusId = "PCI:0:2:0";
      # amdgpuBusId = "PCI:54:0:0}"; #For AMD GPU
    };

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  
  # hardware.nvidia-container-toolkit.enable = lib.mkIf machineConfig.hasNvidia true;
}
