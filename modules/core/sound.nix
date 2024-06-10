{ pkgs, inputs, ... }: 
{
  imports = with inputs; [ 
    nixos-apple-silicon.nixosModules.apple-silicon-support
  ];

  hardware.asahi.setupAsahiSound = true;
  sound.enable = true;
  # hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    jack.enable = true;
    alsa.enable = true;
  #   alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    # lowLatency.enable = true;
  };

  environment.systemPackages = with pkgs; [
  	wireplumber
  ];
}
