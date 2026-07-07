{ config, pkgs, ... }:

{
  users.users.cheeze = {
    isNormalUser = true;
    description = "cheezecake";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.bash;
  };
}
