{ config, pkgs, ... }:

{
  imports = [
    # Hardware
    ./hardware-configuration.nix 
    ./filesystems.nix
    ./private.nix

    # System modules
    ../../modules/editors.nix
    ../../modules/fonts.nix
    ../../modules/nvidia.nix
    ../../modules/audio.nix
    ../../modules/services.nix
    ../../modules/virtualisation.nix
    ../../modules/databases.nix
    
    # Desktop environment
    ../../modules/desktop/hyprland.nix
    ../../modules/desktop/sddm.nix
    ../../modules/desktop/ricing.nix
    
    # Programs
    ../../modules/development.nix
    ../../modules/programs.nix
    
    # Security
    ../../modules/security/secure-boot.nix
    
    # Users
    ../../users/cheeze.nix
  ];

  # Enable nix-command and flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Networking
  networking.networkmanager.enable = true;
  networking.hostName = "nixos";

  # Bootloader
  boot.loader = {
    grub.enable = false;
    systemd-boot.enable = false;
    efi.canTouchEfiVariables = true;
  };
  boot.blacklistedKernelModules = [ "nouveau" ];

  # Timezone and Locale
  time.timeZone = "America/Sao_Paulo";
  
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Console keymap
  console.keyMap = "us";

  # X11 keymap
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # State version
  system.stateVersion = "25.05";
}
