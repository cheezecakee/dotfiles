{ self, inputs, ... }: {
    flake.nixosModules.myMachineHardware = { config, lib, pkgs, modulesPath, ... }: {
      imports =
        [ (modulesPath + "/installer/scan/not-detected.nix")
        ];

      boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "sd_mod" ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-amd" ];
      boot.extraModulePackages = [ ];

      fileSystems."/" =
        { device = "/dev/disk/by-uuid/5bca81e9-7e0c-444a-833f-4412c357a9ad";
          fsType = "ext4";
        };

      fileSystems."/boot" =
        { device = "/dev/disk/by-uuid/B4F0-B8FE";
          fsType = "vfat";
          options = [ "fmask=0022" "dmask=0022" ];
        };

      swapDevices = [ ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
