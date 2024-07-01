{ pkgs, config, inputs, modulesPath, lib, ... }:
{  
  imports = with inputs; [
  	nixos-apple-silicon.nixosModules.apple-silicon-support
    ../../hosts/main/hardware.nix
  ];

  hardware.bluetooth.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  hardware.asahi = {
  	peripheralFirmwareDirectory = ../../firmware;
  	useExperimentalGPUDriver = true;
  	experimentalGPUInstallMode = "replace";
  	withRust = true;
  };

  zramSwap.enable = true;

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = false;
    };

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
