{ config, pkgs, ... }:

{
  # Enable PipeWire for audio
  security.rtkit.enable = true;
  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # Audio control GUI (from packages)
  environment.systemPackages = with pkgs; [
    pavucontrol
  ];
}
