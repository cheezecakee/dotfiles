{ config, pkgs, ... }:
{
  fonts = {
    fontconfig.enable = true; # enables fontconfig system-wide
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
    ];
  };
}
