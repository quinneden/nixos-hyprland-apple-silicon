{ self, pkgs, lib, inputs, ...}: 
{
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 4d";
    };
  };
  
  nixpkgs = {
    overlays = with inputs; [
      nixos-apple-silicon.overlays.apple-silicon-overlay
      inputs.nur.overlay
    ];
  };

  environment.systemPackages = with pkgs; [
    asahi-bless
    asahi-btsync
    asahi-nvram
    btrfs-progs
    gparted
    git
    wget
  ];

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.05";
}
