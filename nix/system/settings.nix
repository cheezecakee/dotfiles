{ inputs, pkgs, ... }:

{
   # Enable nix-command and flakes
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    warn-dirty = false;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Auto mount USB drives
  services = {
    devmon.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
  };

  # Power management
  services.power-profiles-daemon.enable = true;

  # Remote desktop
  services.xrdp.enable = true;

  # SSH
  services.openssh.enable = true;

  # Enable elogind for session management
  services.dbus.enable = true;

  # Enable X server 
  services.xserver.enable = true;

  # USB management utilities
  environment.systemPackages = with pkgs; [
    power-profiles-daemon
    udisks2
    inputs.self.packages.${pkgs.system}.dotfiles-scripts
  ];
}
