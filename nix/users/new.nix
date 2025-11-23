{ config, pkgs, ... }:

{
  users.users.new = {
    isNormalUser = true;
    description = "change this user name";
    extraGroups = [ "networkmanager" "wheel" ];
    mutableUser = true;
    shell = pkgs.bash;
  };
}
