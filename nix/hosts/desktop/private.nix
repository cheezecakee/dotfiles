{ config, pkgs, ... }:

{
  # Private database configuration
  services.postgresql = {
    authentication = ''
      local all all trust
    '';
  };
}
