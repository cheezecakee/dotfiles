{ inputs, pkgs, self, ... }:

{
  environment.systemPackages = with pkgs; [
    # File manager 
    superfile

    # Text Editors & Note Taking
    obsidian

    # Terminal
    ghostty

    # Communication
    discord

    # Media
    vlc
    obs-studio
    spotify

    # Development IDEs
    # android-studio

    # Gaming
    steam

    # Utilities
    pavucontrol  # Audio control GUI
    
    # Browser
    # zen-browser
    firefox
    brave
    google-chrome

    caligula

    # Minecraft
    prismlauncher
  ];
}
