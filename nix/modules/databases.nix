{ config, pkgs, ... }:

{
  # Enable PostgreSQL
  services.postgresql.enable = true;

  # Disable MongoDB (not currently needed)
  services.mongodb.enable = false;

  # Database CLI tools
  environment.systemPackages = with pkgs; [
    postgresql
    mongodb
  ];
}
