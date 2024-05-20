{ lib, inputs, pkgs, config, ... }: 

{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;

    settings = {
      directory.substitutions = {
        "~" = "homedir";
        "lazarus" = " Lazarus";
      };
      cmd_duration = {
        disabled = true;
      };
      git_branch = {
        symbol = " ";
      };
      nix_shell = {
        symbol = " ";
      };
      git_status = {
        style = "yellow";
      };
      palette = "catppuccin_mocha";
    } // builtins.fromTOML (builtins.readFile "${inputs.catppuccin-starship}/palettes/mocha.toml");
  };
}
