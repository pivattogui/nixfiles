{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;

    # Font configuration
    font = {
      name = "JetBrains Mono";
      size = 12;
    };

    # Structured settings
    settings = {
      # Font settings
      disable_ligatures = "never";
      symbol_map = "U+E0A0-U+E0A3,U+E0C0-U+E0C7 PowerlineSymbols";

      # Audio
      enable_audio_bell = false;

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
      open_urls_in_browser = true;
      url_style = "curly";

      # Terminal type
      term = "xterm-kitty";

      # Tabs
      tab_title_max_length = 24;

      # Opacity and blur
      background_opacity = "0.60";
      dynamic_background_opacity = true;
      background_blur = 40;

      # Window border
      window_border_width = "1pt";
      draw_minimal_borders = true;

      # Colors - Basic
      foreground = "#f8f8f8";
      background = "#1f1f1f";
      selection_foreground = "#1f1f1f";
      selection_background = "#79b8ff";

      # Colors - Cursor
      cursor = "#f8f8f8";
      cursor_text_color = "#1f1f1f";

      # Colors - URL
      url_color = "#79b8ff";

      # Colors - Window borders
      active_border_color = "#79b8ff";
      inactive_border_color = "#6b737c";
      bell_border_color = "#FF9800";

      # Colors - Titlebar
      wayland_titlebar_color = "system";
      macos_titlebar_color = "system";

      # Colors - Tabs
      active_tab_foreground = "#f8f8f8";
      active_tab_background = "#383838";
      inactive_tab_foreground = "#888888";
      inactive_tab_background = "#1A1A1A";
      tab_bar_background = "#1A1A1A";

      # Colors - Marks
      mark1_foreground = "#1f1f1f";
      mark1_background = "#79b8ff";
      mark2_foreground = "#1f1f1f";
      mark2_background = "#b392f0";
      mark3_foreground = "#1f1f1f";
      mark3_background = "#9db1c5";

      # Terminal colors - Black
      color0 = "#1A1A1A";
      color8 = "#5c5c5c";

      # Terminal colors - Red
      color1 = "#f97583";
      color9 = "#FF7A84";

      # Terminal colors - Green
      color2 = "#85e89d";
      color10 = "#85e89d";

      # Terminal colors - Yellow
      color3 = "#ffab70";
      color11 = "#FF9800";

      # Terminal colors - Blue
      color4 = "#79b8ff";
      color12 = "#b392f0";

      # Terminal colors - Magenta
      color5 = "#f97583";
      color13 = "#FF7A84";

      # Terminal colors - Cyan
      color6 = "#9db1c5";
      color14 = "#79b8ff";

      # Terminal colors - White
      color7 = "#bbbbbb";
      color15 = "#f8f8f8";
    };

    # Key bindings (kept in extraConfig as they're easier to maintain this way)
    keybindings = {
      # New tab
      "cmd+t" = "new_tab_with_cwd";

      # Search
      "ctrl+f" = "launch --type=overlay --stdin-source=@screen_scrollback ${pkgs.fzf}/bin/fzf --no-sort --no-mouse --exact -i";

      # Create windows
      "cmd+shift+n" = "launch --location=hsplit --cwd=current";
      "cmd+n" = "launch --location=vsplit --cwd=current";

      # Navigate between windows
      "cmd+left" = "neighboring_window left";
      "cmd+right" = "neighboring_window right";
      "cmd+up" = "neighboring_window up";
      "cmd+down" = "neighboring_window down";

      # Resize windows
      "cmd+shift+up" = "resize_window taller";
      "cmd+shift+down" = "resize_window shorter";
      "cmd+shift+left" = "resize_window narrower";
      "cmd+shift+right" = "resize_window wider";

      # Layout
      "cmd+l" = "next_layout";

      # Tab navigation
      "cmd+1" = "goto_tab 1";
      "cmd+2" = "goto_tab 2";
      "cmd+3" = "goto_tab 3";
      "cmd+4" = "goto_tab 4";
      "cmd+5" = "goto_tab 5";
      "cmd+6" = "goto_tab 6";
      "cmd+7" = "goto_tab 7";
      "cmd+8" = "goto_tab 8";
      "cmd+9" = "goto_tab 9";
      "cmd+]" = "next_tab";
      "cmd+[" = "previous_tab";

      # Close
      "cmd+shift+w" = "close_tab";
      "cmd+w" = "close_window";
    };
  };
}
