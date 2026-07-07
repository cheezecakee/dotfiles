{ inputs, self, ... }:
{
    flake.nixosModules.utilsMod = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [
            # Wallpaper
            awww

            # Audio
            mpdris2
        ];
    };
}

