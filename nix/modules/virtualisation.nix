{ config, pkgs, ... }:

{
  virtualisation.docker.enable = true;

  # Docker CLI tool
  environment.systemPackages = with pkgs; [
    docker
  ];

  # Add your user to docker group (reference from users.nix)
  # Already handled in users/cheeze.nix via extraGroups = [ "docker" ];
}
