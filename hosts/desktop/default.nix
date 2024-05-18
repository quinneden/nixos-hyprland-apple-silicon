{ pkgs, ... }: 
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
  ];

  # powerManagement.cpuFreqGovernor = "performance";
  zramSwap.enable = true;
  
}