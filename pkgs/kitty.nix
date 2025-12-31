{ pkgs, lib, ... }:
let
  isDarwin = pkgs.stdenv.isDarwin;

  # Platform-specific modifiers
  modifier = if isDarwin then "cmd" else "alt";
  shiftModifier = if isDarwin then "cmd+shift" else "alt+shift";

  # Common settings (shared across all platforms)
  commonSettings = {
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
    url_style = "curly";

    # Terminal type
    term = "xterm-kitty";

    # Tabs
    tab_title_max_length = 24;

    # Window border
    window_border_width = "1pt";
    draw_minimal_borders = true;
  };

  # Darwin-specific settings (macOS)
  darwinSettings = {
    background_opacity = "0.60";
    dynamic_background_opacity = true;
    background_blur = 40;
  };

  # Linux-specific settings (NixOS/Wayland)
  linuxSettings = {
    linux_display_server = "auto";
  };

  # Merge settings based on platform
  platformSettings = if isDarwin then darwinSettings else linuxSettings;
in
{
  programs.kitty = {
    enable = true;
    themeFile = "Min_Dark";

    # Font configuration
    font = {
      name = "JetBrains Mono";
      size = 12;
    };

    # Merge common + platform-specific settings
    settings = commonSettings // platformSettings;

    # Key bindings (use cmd on macOS, ctrl on Linux)
    keybindings = {
      # New tab
      "${modifier}+t" = "new_tab_with_cwd";

      # Search
      "ctrl+f" = "launch --type=overlay --stdin-source=@screen_scrollback ${pkgs.fzf}/bin/fzf --no-sort --no-mouse --exact -i";

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

    # Environment variables for better Wayland compatibility
    environment = if isDarwin then {} else {
      # Disable experimental Wayland protocols that cause issues
      "WAYLAND_DISPLAY" = "wayland-1";
    };
  };
}
