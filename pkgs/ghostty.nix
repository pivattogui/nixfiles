_: {
  programs.ghostty = {
    enable = true;
    package = null;
    enableZshIntegration = true;

    settings = {
      font-family = "JetBrainsMono Nerd Font";
      font-size = 12;

      foreground = "f8f8f8";
      background = "1f1f1f";
      selection-foreground = "1f1f1f";
      selection-background = "79b8ff";
      cursor-color = "f8f8f8";
      cursor-text = "1f1f1f";
      palette = [
        "0=1A1A1A"
        "1=f97583"
        "2=85e89d"
        "3=ffab70"
        "4=79b8ff"
        "5=f97583"
        "6=9db1c5"
        "7=bbbbbb"
        "8=5c5c5c"
        "9=FF7A84"
        "10=85e89d"
        "11=FF9800"
        "12=b392f0"
        "13=FF7A84"
        "14=79b8ff"
        "15=f8f8f8"
      ];

      background-opacity = 0.60;
      background-blur = 40;
      window-padding-x = 0;
      window-padding-y = 0;
      window-save-state = "never";

      mouse-scroll-multiplier = 3;
      bell-features = "no-audio";
      confirm-close-surface = false;

      tab-inherit-working-directory = true;
      split-inherit-working-directory = true;

      keybind = [
        "cmd+t=new_tab"
        "cmd+f=start_search"

        "ctrl+shift+r=ignore"
        "cmd+r=ignore"

        "cmd+shift+n=new_split:down"
        "cmd+n=new_split:right"

        "cmd+left=goto_split:left"
        "cmd+right=goto_split:right"
        "cmd+up=goto_split:up"
        "cmd+down=goto_split:down"

        "cmd+shift+up=resize_split:up,10"
        "cmd+shift+down=resize_split:down,10"
        "cmd+shift+left=resize_split:left,10"
        "cmd+shift+right=resize_split:right,10"

        "cmd+l=toggle_split_zoom"

        "cmd+1=goto_tab:1"
        "cmd+2=goto_tab:2"
        "cmd+3=goto_tab:3"
        "cmd+4=goto_tab:4"
        "cmd+5=goto_tab:5"
        "cmd+6=goto_tab:6"
        "cmd+7=goto_tab:7"
        "cmd+8=goto_tab:8"
        "cmd+9=goto_tab:9"
        "cmd+]=next_tab"
        "cmd+[=previous_tab"

        "cmd+shift+w=close_tab"
        "cmd+w=close_surface"

        "cmd+c=copy_to_clipboard"
        "cmd+v=paste_from_clipboard"
        "cmd+k=clear_screen"

        "cmd+a=ignore"
        "cmd+b=ignore"
        "cmd+d=ignore"
        "cmd+e=ignore"
        "cmd+g=ignore"
        "cmd+i=ignore"
        "cmd+j=ignore"
        "cmd+o=ignore"
        "cmd+p=ignore"
        "cmd+s=ignore"
        "cmd+u=ignore"
        "cmd+x=ignore"
        "cmd+y=ignore"
        "cmd+z=ignore"
      ];
    };
  };
}
