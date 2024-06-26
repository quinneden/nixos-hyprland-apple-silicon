{pkgs, ...}: let
  wall-change = pkgs.writeShellScriptBin "wall-change" ''swaybg -m fill -i $1'';
  wallpaper-picker = pkgs.writeShellScriptBin "wallpaper-picker" (builtins.readFile ./scripts/wallpaper-picker.sh);
  
  runbg = pkgs.writeShellScriptBin "runbg" (builtins.readFile ./scripts/runbg.sh);
  music = pkgs.writeShellScriptBin "music" (builtins.readFile ./scripts/music.sh);
  lofi = pkgs.writeScriptBin "lofi" (builtins.readFile ./scripts/lofi.sh);
  
  toggle_blur = pkgs.writeScriptBin "toggle_blur" (builtins.readFile ./scripts/toggle_blur.sh);
  toggle_oppacity = pkgs.writeScriptBin "toggle_oppacity" (builtins.readFile ./scripts/toggle_oppacity.sh);
  
  maxfetch = pkgs.writeScriptBin "maxfetch" (builtins.readFile ./scripts/maxfetch.sh);
  
  compress = pkgs.writeScriptBin "compress" (builtins.readFile ./scripts/compress.sh);
  extract = pkgs.writeScriptBin "extract" (builtins.readFile ./scripts/extract.sh);
  
  shutdown-script = pkgs.writeScriptBin "shutdown-script" (builtins.readFile ./scripts/shutdown-script.sh);
  
  show-keybinds = pkgs.writeScriptBin "show-keybinds" (builtins.readFile ./scripts/keybinds.sh);
  
  vm-start = pkgs.writeScriptBin "vm-start" (builtins.readFile ./scripts/vm-start.sh);

  ascii = pkgs.writeScriptBin "ascii" (builtins.readFile ./scripts/ascii.sh);

  cfg = pkgs.writeScriptBin "cfg" (builtins.readFile ./scripts/cfg.sh);
  bless = pkgs.writeScriptBin "bless" (builtins.readFile ./scripts/bless.sh);
  colortable = pkgs.writeScriptBin "colortable" (builtins.readFile ./scripts/colortable.sh);
  clone = pkgs.writeScriptBin "clone" (builtins.readFile ./scripts/clone.sh);
in {
  home.packages = with pkgs; [
    wall-change
    wallpaper-picker
    
    runbg
    music
    lofi
  
    toggle_blur
    toggle_oppacity

    maxfetch

    compress
    extract

    shutdown-script
    
    show-keybinds

    vm-start

    ascii
    
    # Personal
    cfg
    bless
    colortable
    clone
  ];
}
