{ self, inputs, ... }:
{
  flake.nixosModules.optMod =
    {
      lib,
      self',
      ...
    }:
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

        secureboot.enable = lib.mkEnableOption "secure boot via lanzaboote";

        machine.type = lib.mkOption {
          type = lib.types.enum [
            "desktop"
            "notebook"
          ];
          default = "notebook";
        };

        powerMode.type = lib.mkOption {
          type = lib.types.enum [
            "balanced"
            "performance"
            "powersave"
          ];
          default = "balanced";
        };

        autoLogin.enable = lib.mkEnableOption "enable auto login";
      };
    };
}
