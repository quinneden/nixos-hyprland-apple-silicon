{ pkgs, ... }: 
{
  programs.kitty = {
    enable = true;

    shellIntegration.enableZshIntegration = true;

    theme = "Catppuccin-Mocha";
    
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 13;
    };

    settings = {
      confirm_os_window_close = 0;
      background_opacity = "0.55";  
      window_padding_width = 10;
      scrollback_lines = 10000;
      enable_audio_bell = false;
      mouse_hide_wait = 5;
      cursor_shape = "beam";
      
      ## Tabs
      tab_title_template = "{index}";
      active_tab_font_style = "normal";
      inactive_tab_font_style = "normal";
      tab_bar_style = "fade";
      active_tab_foreground = "#1e1e2e";
      active_tab_background = "#cba6f7";
      inactive_tab_foreground = "#bac2de";
      inactive_tab_background = "#313244";
    };

    keybindings = {  
      ## Tabs
      "ctrl+1" = "goto_tab 1";
      "ctrl+2" = "goto_tab 2";
      "ctrl+3" = "goto_tab 3";
      "ctrl+4" = "goto_tab 4";
      "ctrl+shift+left" = "previous_tab";
      "ctrl+shift+right" = "next_tab";
      ## Scrolling
      "page_up" = "scroll_page_up";
      "page_down" = "scroll_page_down";
    };
  };
}
