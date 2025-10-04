{ config, pkgs, ... }:

{
  users.groups.cheeze = {};
  users.users.cheeze = {
    isNormalUser = true;
    description = "cheezecake";
    uid = 1000;
    group = "cheeze";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    home = "/home/cheeze";
    createHome = true;
    shell = pkgs.bash;
    packages = with pkgs; [ ];
  };
}
