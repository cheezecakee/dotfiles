{ config, pkgs, ... }:

{
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
}
