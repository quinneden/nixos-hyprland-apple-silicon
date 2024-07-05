{ inputs, pkgs, ... }: 
{
  home.packages = (with pkgs; [
    bitwise                           
    bleachbit                         
    cinnamon.nemo-with-extensions     
    cmatrix
    ddcutil
    edk2
    entr                              
    eza                               
    fd                                
    ffmpeg
    file                              
    fzf                               
    gcc
    gnome.zenity
    gnumake
    go
    hdrop
    hexdump
    imv                               
    inputs.alejandra.defaultPackage.${system}
    jdk17                             
    jq
    just
    lazygit
    libnotify
    libvirt
    lima
	  man-pages					     
    mpv                               
    ncdu                              
    nitch                             
    nix-prefetch-github
    openssl
    pamixer                           
    pavucontrol
    playerctl
    poweralertd
    python3
    qalculate-gtk
    qemu
    ripgrep                           
    todo                              
    unzip
    vagrant
    wget
    xdg-utils
    xorriso
    xxd
    yazi 
  ]);
}
