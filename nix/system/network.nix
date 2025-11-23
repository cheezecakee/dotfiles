{ ... }:

{
  networking.networkmanager.enable = true;
  networking.wireless.iwd.enable = false;
  networking.wireless.iwd.settings = {
      Settings = {
      AutoConnect = true;
    };
  };
}
