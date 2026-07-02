{ ... }:

{

  imports = [
    # Hardware (you'll need to copy these from your old setup)
    ./hardware-configuration.nix
    
    # System modules
    ../system/audio.nix
    ../system/boot.nix
    ../system/cli.nix
    ../system/database.nix
    ../system/dev.nix
    ../system/docker.nix
    ../system/editor.nix
    ../system/fonts.nix
    ../system/graphics.nix
    ../system/hyprland.nix
   ../system/libraries.nix
    ../system/network.nix
    ../system/region.nix
    ../system/sddm.nix
    ../system/settings.nix
    ../system/utils.nix
    ../system/apps.nix
    
    # User
    ../users/cheeze.nix
  ];

  networking.hostName = "desktop";

  # Mount external NTFS drives
  fileSystems."/home/cheeze/work" = {
    device = "/dev/disk/by-uuid/CA96A59396A58095";
    fsType = "ntfs-3g";
    options = [ "defaults" "nofail" "uid=1000" "gid=988" "umask=022" ];
  };

  fileSystems."/home/cheeze/games" = {
    device = "/dev/disk/by-uuid/222A78A02A787321";
    fsType = "ntfs-3g";
    options = [ "defaults" "nofail" "uid=1000" "gid=988" "umask=022" ];
  };

  system.stateVersion = "25.05";
}
