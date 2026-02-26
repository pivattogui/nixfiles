{ pkgs, lib, ... }:
let
  inherit (pkgs.stdenv) isDarwin;

  modifier = if isDarwin then "cmd" else "ctrl";
  shiftModifier = if isDarwin then "cmd+shift" else "ctrl+shift";

  superKeys = lib.strings.stringToCharacters "abcdefghijklmnopqrstuvwxyz0123456789";
  superDiscardBindings = if isDarwin then {} else
    lib.listToAttrs (map (key: {
      name = "super+${key}";
      value = "discard_event";
    }) superKeys);

  # Common settings (shared across all platforms)
  commonSettings = {
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
  };

  # Darwin-specific settings (macOS)
  darwinSettings = {
    background_opacity = "0.60";
    dynamic_background_opacity = true;
    background_blur = 40;
    term = "xterm-kitty";
    allow_remote_control = "yes";
  };

  linuxSettings = {
    linux_display_server = "auto";
    term = "xterm-256color";
    shell_integration = "disabled";
    background_opacity = "0.90";
    include = "~/.local/state/caelestia/theme/kitty.conf";
  };

  platformSettings = if isDarwin then darwinSettings else linuxSettings;
in
{
  programs.kitty = {
    enable = true;
    themeFile = if isDarwin then "vague" else null;

    # Font configuration
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };

    settings = commonSettings // platformSettings;

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
    } // superDiscardBindings;

    # Environment variables for better Wayland compatibility
    environment = if isDarwin then {} else {
      # Disable experimental Wayland protocols that cause issues
      "WAYLAND_DISPLAY" = "wayland-1";
    };
  };
}
