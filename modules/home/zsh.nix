{ hostname, config, pkgs, host, ...}: 
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "fzf" "eza" "zsh-navigation-tools" ];
    };
    initExtraFirst = ''
      DISABLE_MAGIC_FUNCTIONS=true
      export "MICRO_TRUECOLOR=1"
    '';
    shellAliases = {
      # record = "wf-recorder --audio=alsa_output.pci-0000_08_00.6.analog-stereo.monitor -f $HOME/Videos/$(date +'%Y%m%d%H%M%S_1.mp4')";

      # Utils
      c = "clear";
      cd = "z";
      # tt = "gtrash put";
      # cat = "bat";
      nano = "micro";
      mi = "micro";
      code = "codium";
      py = "python";
      icat = "kitten icat";
      dsize = "du -hs";
      findw = "grep -rl";
      surf = "sudo rm -rf";
      rf = "rm -rf";

      l = "eza --icons  -a --group-directories-first"; #EZA_ICON_SPACING=2
      la = "eza -a1";
      ll = "eza --icons  -a --group-directories-first -1 --no-user --long";
      tree = "eza --icons --tree --group-directories-first";

      # Nixos
      cdnix = "cd ~/.config/lazarus";
      codenix = "cd ~/.config/lazarus && codium ~/.config/lazarus";
      ns = "nix-shell --run zsh";
      nix-shell = "nix-shell --run zsh";
      nix-switch = "sudo nixos-rebuild switch --flake ~/.config/lazarus#${host} --impure";
      nix-switchu = "sudo nixos-rebuild switch --upgrade --flake ~/.config/lazarus#${host} --impure";
      flake-update = "sudo nix flake update ~/.config/lazarus#";
      nix-clean = "sudo nix-collect-garbage && sudo nix-collect-garbage -d && sudo rm /nix/var/nix/gcroots/auto/* && nix-collect-garbage && nix-collect-garbage -d";

      # Git
      ga   = "git add";
      gaa  = "git add --all";
      gs   = "git status";
      gb   = "git branch";
      gm   = "git merge";
      gpl  = "git pull";
      gplo = "git pull origin";
      gps  = "git push";
      gpst = "git push --follow-tags";
      gpso = "git push origin";
      gc   = "git commit";
      gcm  = "git commit -m";
      gcma = "git add --all && git commit -m";
      gtag = "git tag -ma";
      gch  = "git checkout";
      gchb = "git checkout -b";
      gcoe = "git config user.email";
      gcon = "git config user.name";
      commit = "git commit -a --allow-empty-message --no-edit";

      # python
      piv = "python -m venv .venv";
      psv = "source .venv/bin/activate";
    };

    initExtra = ''
      PROMPT='%{$fg_bold[blue]%}$(get_pwd)%{$reset_color%} ''${prompt_suffix}'
      local prompt_suffix="%(?:%{$fg_bold[green]%}❯ :%{$fg_bold[red]%}❯%{$reset_color%} "
      RPROMPT=

      function get_pwd(){
          git_root=$PWD
          while [[ $git_root != / && ! -e $git_root/.git ]]; do
              git_root=$git_root:h
          done
          if [[ $git_root = / ]]; then
              unset git_root
              prompt_short_dir=%~
          else
              parent=''${git_root%\/*}
              prompt_short_dir=''${PWD#$parent/}
          fi
          echo $prompt_short_dir
      }

      vterm_printf(){
          if [ -n "$TMUX" ]; then
              # Tell tmux to pass the escape sequences through
              # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
              printf "\ePtmux;\e\e]%s\007\e\\" "$1"
          elif [ "''${TERM%%-*}" = "screen" ]; then
              # GNU screen (screen, screen-256color, screen-256color-bce)
              printf "\eP\e]%s\007\e\\" "$1"
          else
              printf "\e]%s\e\\" "$1"
          fi
      }
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

}
