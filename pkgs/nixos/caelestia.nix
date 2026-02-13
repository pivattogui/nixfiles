{ pkgs, caelestia-shell, caelestia-cli, ... }:
let
  shellPackage = caelestia-shell.packages.${pkgs.system}.default;
  cliPackage = caelestia-cli.packages.${pkgs.system}.with-shell;

  wallpaperPicker = pkgs.writeShellScriptBin "wallpaper-picker" ''
    WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

    # Open file dialog
    SELECTED=$(${pkgs.zenity}/bin/zenity --file-selection \
      --title="Select Wallpaper" \
      --filename="$WALLPAPER_DIR/" \
      --file-filter="Images | *.jpg *.jpeg *.png *.webp *.gif" \
      2>/dev/null)

    # Apply selected wallpaper
    if [ -n "$SELECTED" ] && [ -f "$SELECTED" ]; then
      caelestia wallpaper -f "$SELECTED"
    fi
  '';

  genKittyColors = pkgs.writeShellScript "gen-kitty-colors" ''
    SCHEME="$HOME/.config/hypr/scheme/current.conf"
    OUTPUT="$HOME/.local/state/caelestia/theme/kitty.conf"

    if [ ! -f "$SCHEME" ]; then
      exit 0
    fi

    mkdir -p "$(dirname "$OUTPUT")"

    # Parse color from scheme file (format: $name = hexvalue)
    get_color() {
      grep "^\$$1 = " "$SCHEME" | cut -d'=' -f2 | tr -d ' '
    }

    cat > "$OUTPUT" << EOF
    # Caelestia-generated Kitty colors
    # Auto-generated - do not edit manually

    foreground #$(get_color onSurface)
    background #$(get_color surface)
    cursor #$(get_color secondary)
    cursor_text_color #$(get_color surface)
    selection_foreground #$(get_color surface)
    selection_background #$(get_color secondary)

    # Normal colors (0-7)
    color0 #$(get_color term0)
    color1 #$(get_color term1)
    color2 #$(get_color term2)
    color3 #$(get_color term3)
    color4 #$(get_color term4)
    color5 #$(get_color term5)
    color6 #$(get_color term6)
    color7 #$(get_color term7)

    # Bright colors (8-15)
    color8 #$(get_color term8)
    color9 #$(get_color term9)
    color10 #$(get_color term10)
    color11 #$(get_color term11)
    color12 #$(get_color term12)
    color13 #$(get_color term13)
    color14 #$(get_color term14)
    color15 #$(get_color term15)

    # Tab bar colors
    active_tab_foreground #$(get_color surface)
    active_tab_background #$(get_color primary)
    inactive_tab_foreground #$(get_color onSurface)
    inactive_tab_background #$(get_color surfaceContainer)

    # Window border
    active_border_color #$(get_color primary)
    inactive_border_color #$(get_color outline)
    EOF

    # Reload kitty config
    pkill -USR1 kitty || true
  '';

  genHyprlockColors = pkgs.writeShellScript "gen-hyprlock-colors" ''
    SCHEME="$HOME/.config/hypr/scheme/current.conf"
    OUTPUT="$HOME/.local/state/caelestia/theme/hyprlock.conf"

    if [ ! -f "$SCHEME" ]; then
      exit 0
    fi

    mkdir -p "$(dirname "$OUTPUT")"

    # Parse color from scheme file
    get_color() {
      grep "^\$$1 = " "$SCHEME" | cut -d'=' -f2 | tr -d ' '
    }

    cat > "$OUTPUT" << EOF
    # Caelestia-generated Hyprlock colors
    # Auto-generated - do not edit manually

    \$caelestia_bg = rgb($(get_color surface))
    \$caelestia_fg = rgb($(get_color onSurface))
    \$caelestia_primary = rgb($(get_color primary))
    \$caelestia_secondary = rgb($(get_color secondary))
    \$caelestia_outline = rgb($(get_color outline))
    \$caelestia_error = rgb($(get_color error))
    \$caelestia_dim = rgb($(get_color surfaceContainerHighest))
    EOF
  '';

  # Caelestia CLI configuration
  cliConfig = {
    theme = {
      enableTerm = true;      # Terminal colors via escape sequences
      enableHypr = true;      # Hyprland colors
      enableGtk = true;       # GTK theming
      enableQt = true;        # Qt theming
      enableBtop = true;      # btop system monitor
      enableCava = true;      # cava audio visualizer
      enableDiscord = false;  # Disable Discord (not using Vencord/etc)
      enableSpicetify = false; # Disable Spicetify (not using Spotify theming)
      enableFuzzel = false;   # Using Caelestia launcher instead
    };
    wallpaper = {
      postHook = "${genKittyColors} && ${genHyprlockColors}";
    };
  };
in
{
  home.packages = with pkgs; [
    shellPackage
    cliPackage
    wallpaperPicker

    # Runtime dependencies
    ddcutil        # DDC/CI monitor control
    libcava        # Audio visualizer
    swappy         # Screenshot annotation
    libqalculate   # Calculator
    material-symbols
    nerd-fonts.caskaydia-cove
  ];

  fonts.fontconfig.enable = true;

  xdg.configFile."caelestia/cli.json".text = builtins.toJSON cliConfig;

  xdg.configFile."caelestia/shell.json".text = builtins.toJSON {
    general = {
      apps = {
        terminal = [ "kitty" ];
        explorer = [ "nautilus" ];
        audio = [ "pavucontrol" ];
      };
    };

    bar = {
      persistent = true;
      showOnHover = true;
      dragThreshold = 20;

      scrollActions = {
        workspaces = true;
        volume = false;
        brightness = false;
      };

      popouts = {
        activeWindow = true;
        tray = true;
        statusIcons = true;
      };

      workspaces = {
        shown = 5;
        activeIndicator = true;
        occupiedBg = false;
        showWindows = true;
        perMonitorWorkspaces = true;
      };

      tray = {
        background = true;
        compact = true;
        recolour = false;
      };

      status = {
        showAudio = true;
        showMicrophone = true;
        showKbLayout = false;
        showNetwork = true;
        showWifi = false;
        showBluetooth = false;
        showBattery = false;
        showLockStatus = false;
      };

      clock = {
        showIcon = true;
      };
    };

    launcher = {
      hiddenApps = [
        "gvim"
        "nixos-manual"
      ];
    };
  };

  systemd.user.services.caelestia-theme-watcher = {
    Unit = {
      Description = "Watch Caelestia wallpaper/scheme changes and sync colors";
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = pkgs.writeShellScript "caelestia-theme-watcher" ''
        SCHEME_FILE="$HOME/.config/hypr/scheme/current.conf"
        WALLPAPER_FILE="$HOME/.local/state/caelestia/wallpaper/path.txt"
        LAST_SCHEME_HASH=""
        LAST_WALLPAPER=""

        while true; do
          # Check for wallpaper changes (Shell UI doesn't extract colors)
          if [ -f "$WALLPAPER_FILE" ]; then
            CURRENT_WALLPAPER=$(cat "$WALLPAPER_FILE")
            if [ "$CURRENT_WALLPAPER" != "$LAST_WALLPAPER" ] && [ -n "$LAST_WALLPAPER" ]; then
              echo "Wallpaper changed to: $CURRENT_WALLPAPER"
              # Trigger color extraction from new wallpaper by refreshing dynamic scheme
              caelestia scheme set -n dynamic || true
            fi
            LAST_WALLPAPER="$CURRENT_WALLPAPER"
          fi

          # Check for scheme changes (updates Kitty/Hyprlock)
          if [ -f "$SCHEME_FILE" ]; then
            CURRENT_SCHEME_HASH=$(md5sum "$SCHEME_FILE" | cut -d' ' -f1)
            if [ "$CURRENT_SCHEME_HASH" != "$LAST_SCHEME_HASH" ]; then
              LAST_SCHEME_HASH="$CURRENT_SCHEME_HASH"
              sleep 0.2
              ${genKittyColors}
              ${genHyprlockColors}
              echo "Colors updated for Kitty and Hyprlock"
            fi
          fi

          sleep 1
        done
      '';
      Restart = "always";
      RestartSec = 5;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
