{ pkgs, config, inputs, ... }:
{  
  imports = with inputs; [
  	nixos-apple-silicon.nixosModules.apple-silicon-support
  ];

  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  # hardware.enableRedistributableFirmware = true;
  # hardware.opengl.extraPackages = with pkgs; [  
  # ];

  hardware.asahi = {
  	peripheralFirmwareDirectory = ../../firmware;
  	useExperimentalGPUDriver = true;
  	experimentalGPUInstallMode = "replace";
  	withRust = true;
  };
}
