{ self, inputs, ... }:
{
    flake.nixosModules.gpuMod = { pkgs, lib, self', config, ... }:
    {
        options = {
            gpu.type = lib.mkOption {
                type = lib.types.enum [
                    "nvidia"
                    "amdgpu"
                    "intel"
                    "none"
                ];
                default = "none";
            };
        };


        config = {
            services.xserver.enable = true;

            # Basic graphics always enabled
            hardware.graphics = {
                enable = true;
                enable32Bit = true;
            };

            # Nvidia-specific config - only if hasNvidia
            services.xserver.videoDrivers =
                if  lib.elem config.gpu.type [ "intel" "none" ] then
                    [ "modesetting" ]
                else 
                    [ config.gpu.type ];
                

            # NVIDIA
            hardware.nvidia = lib.mkIf (config.gpu.type == "nvidia") {
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
                # hardware.nvidia-container-toolkit.enable = lib.mkIf machineConfig.hasNvidia true;
            };

        };
    };
}
