{ self, inputs, ... }:
{
    flake.nixosModules.systemMod = { pkgs, lib, self', config, ... }:
    {
        imports = [
            self.nixosModules.bootMod
            self.nixosModules.devMod
            self.nixosModules.editorMod
            self.nixosModules.fontsMod
            self.nixosModules.regionMod
            self.nixosModules.utilsMod
        ];

        nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
        warn-dirty = false;
        };

        nixpkgs.config.allowUnfree = true;

        # Power management
        services.power-profiles-daemon.enable = true;

        # Remote desktop
        services.xrdp.enable = true;

        # SSH
        services.openssh.enable = true;

        # Enable elogind for session management
        services.dbus.enable = true;


        # USB management utilities
        environment.systemPackages = with pkgs; [
            power-profiles-daemon
            self.packages.${pkgs.stdenv.hostPlatform.system}.dotfiles-scripts
        ];
    };
}
