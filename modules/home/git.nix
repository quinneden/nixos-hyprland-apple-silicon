{ pkgs, ... }: 
{
  programs.git = {
    enable = true;
    
    userName = "Quinn Edenfield";
    userEmail = "quinnyxboy@gmail.com";
    
    extraConfig = { 
      init.defaultBranch = "main";
      credential.helper = "store";
      http.postBuffer = "524288000";
    };
  };

  home.packages = [ pkgs.gh pkgs.git-lfs ];
}
