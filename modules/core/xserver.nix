{ pkgs, username, ... }: 
{
  services.xserver = {
    enable = false;
    xkb.layout = "us";
  };

  services.libinput = {
      enable = true;
      # mouse = {
      #   accelProfile = "flat";
      # };
  };
  # To prevent getting stuck at shutdown
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";
}
