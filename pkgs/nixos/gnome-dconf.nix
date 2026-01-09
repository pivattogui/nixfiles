{ pkgs, lib, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
in
{
  # GNOME dconf settings (only on Linux)
  dconf.settings = if isDarwin then {} else {
    # Desktop interface preferences
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      clock-format = "24h";
      enable-animations = true;
    };

    # Session idle settings
    "org/gnome/desktop/session" = {
      idle-delay = lib.hm.gvariant.mkUint32 1800; # 30 minutes
    };

    # Window manager preferences
    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":minimize,maximize,close"; # Buttons on right side
    };

    # Mutter (window manager) settings
    "org/gnome/mutter" = {
      edge-tiling = true;
      dynamic-workspaces = true;
    };

    # Shell favorite apps
    "org/gnome/shell" = {
      favorite-apps = [
        "1password.desktop"
        "kitty.desktop"
        "dev.zed.Zed.desktop"
        "obsidian.desktop"
        "floorp.desktop"
        "discord.desktop"
        "steam.desktop"
        "spotify.desktop"
      ];
      enabled-extensions = [
        "dash-to-dock@micxgx.gmail.com"
        "blur-my-shell@aunetx"
      ];
    };

    # Dash to Dock extension settings
    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position = "BOTTOM";
      click-action = "previews";
      middle-click-action = "launch";
      intellihide = true;
      intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
      dash-max-icon-size = 32;
      show-trash = false;
      hot-keys = false;
      show-show-apps-button = true;
      animation-time = 0.2;
      hide-delay = 0.0;
      show-delay = 0.0;
    };

    # Blur My Shell extension settings
    "org/gnome/shell/extensions/blur-my-shell" = {
      brightness = 0.75;
      noise-amount = 0.0;
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      blur = true;
    };

    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = true;
    };
  };
}
