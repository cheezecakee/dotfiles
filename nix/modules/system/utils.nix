{ inputs, self, ... }:
{
  flake.nixosModules.utilsMod = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      # Wallpaper
      awww

      lazygit

      libnotify

      # Audio
      mpdris2
    ];
  };
}
