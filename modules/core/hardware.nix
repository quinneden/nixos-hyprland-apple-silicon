{ pkgs, config, inputs, modulesPath, lib, ... }:
{  
  imports = with inputs; [
  	nixos-apple-silicon.nixosModules.apple-silicon-support
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  hardware.bluetooth.enable = true;

  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;

  hardware.asahi = {
  	peripheralFirmwareDirectory = ../../firmware;
  	useExperimentalGPUDriver = true;
  	experimentalGPUInstallMode = "replace";
  	withRust = true;
  };

  zramSwap.enable = true;

  boot.initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/13453dcd-9d3f-4007-9787-e02ea9f0144d";
      fsType = "btrfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/8434-16F7";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
