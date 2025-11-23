{ config, pkgs, ... }:

{
  users.users.default = {
    isNormalUser = true;
    description = "change this user name";
    extraGroups = [ "networkmanager" "wheel" ];
    mutableUser = true;
    shell = pkgs.bash;
  };
}
