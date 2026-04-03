{ pkgs, ... }:
let
  modifier = "cmd";
  shiftModifier = "cmd+shift";
in
{
  programs.kitty = {
    enable = true;
    themeFile =  "Min_Dark";

    # Font configuration
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };

    settings = {
      # Font settings
      disable_ligatures = "never";
      symbol_map = "U+E0A0-U+E0A3,U+E0C0-U+E0C7 PowerlineSymbols";

      # Audio
      enable_audio_bell = false;

      # Close without confirmation
      confirm_os_window_close = 0;

      # Window
      window_padding_width = 0;
      remember_window_size = false;
      initial_window_width = 1200;
      initial_window_height = 750;
      enabled_layouts = "splits,stack";
      hide_window_decorations = false;

      # Scrollback
      scrollback_lines = 5000;
      wheel_scroll_multiplier = "3.0";

      # URLs
      detect_urls = true;
      url_style = "curly";

      # Tabs
      tab_title_max_length = 24;

      # Window border
      window_border_width = "1pt";
      draw_minimal_borders = true;

      # macOS settings
      background_opacity = "0.60";
      dynamic_background_opacity = true;
      background_blur = 40;
      term = "xterm-kitty";
      allow_remote_control = "yes";
    };

    keybindings = {
      # New tab
      "${modifier}+t" = "new_tab_with_cwd";

      # Search in zsh history
      "${modifier}+r" = "launch --type=overlay --allow-remote-control sh -c 'cmd=$(cat ~/.zsh_history | ${pkgs.fzf}/bin/fzf --tac --no-sort --no-mouse --exact -i) && [ -n \"$cmd\" ] && kitty @ send-text \"$cmd\"'";

      # Search in terminal scrollback
      "${modifier}+f" = "launch --type=overlay --stdin-source=@screen_scrollback ${pkgs.fzf}/bin/fzf --no-sort --no-mouse --exact -i";

      # Disable resize mode
      "ctrl+shift+r" = "no_op";

      # Create windows
      "${shiftModifier}+n" = "launch --location=hsplit --cwd=current";
      "${modifier}+n" = "launch --location=vsplit --cwd=current";

      # Navigate between windows
      "${modifier}+left" = "neighboring_window left";
      "${modifier}+right" = "neighboring_window right";
      "${modifier}+up" = "neighboring_window up";
      "${modifier}+down" = "neighboring_window down";

      # Resize windows
      "${shiftModifier}+up" = "resize_window taller";
      "${shiftModifier}+down" = "resize_window shorter";
      "${shiftModifier}+left" = "resize_window narrower";
      "${shiftModifier}+right" = "resize_window wider";

      # Layout
      "${modifier}+l" = "next_layout";

      # Tab navigation
      "${modifier}+1" = "goto_tab 1";
      "${modifier}+2" = "goto_tab 2";
      "${modifier}+3" = "goto_tab 3";
      "${modifier}+4" = "goto_tab 4";
      "${modifier}+5" = "goto_tab 5";
      "${modifier}+6" = "goto_tab 6";
      "${modifier}+7" = "goto_tab 7";
      "${modifier}+8" = "goto_tab 8";
      "${modifier}+9" = "goto_tab 9";
      "${modifier}+]" = "next_tab";
      "${modifier}+[" = "previous_tab";

      # Close
      "${shiftModifier}+w" = "close_tab";
      "${modifier}+w" = "close_window";
    };

  };
}
