_: {
  # Zed editor configuration
  # Zed is installed via Homebrew Cask on macOS, nixpkgs on Linux
  # This module manages the editor's settings declaratively

  xdg.configFile."zed/settings.json".text = builtins.toJSON {
    # Cursor
    cursor_shape = "block";

    # Font Configuration
    ui_font_family = "JetBrains Mono";
    ui_font_size = 15.0;
    ui_font_weight = 400.0;
    buffer_font_family = "JetBrains Mono";
    buffer_font_size = 15;
    agent_ui_font_size = 15.0;

    # Code Formatting
    tab_size = 2;

    # Window & Tabs
    use_system_window_tabs = true;
    active_pane_modifiers = {
      inactive_opacity = 0.0;
    };

    tabs = {
      file_icons = true;
      git_status = false;
    };

    tab_bar = {
      show = true;
    };

    title_bar = {
      show_menus = false;
      show_branch_icon = false;
    };

    # Panels
    debugger = {
      dock = "right";
    };

    notification_panel = {
      button = false;
    };

    collaboration_panel = {
      button = false;
    };

    git_panel = {
      button = true;
    };

    outline_panel = {
      file_icons = true;
      button = true;
      git_status = true;
    };

    # Terminal
    terminal = {
      dock = "right";
      font_family = ".ZedMono";
    };

    # Editor Behavior
    vim_mode = true;
    base_keymap = "Cursor";

    # Theme
    theme = {
      mode = "system";
      light = "Oscura";
      dark = "Oscura";
    };

    # Privacy & Telemetry
    telemetry = {
      diagnostics = false;
      metrics = false;
    };
    redact_private_values = false;
  };
}
