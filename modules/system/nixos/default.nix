{ pkgs, lib, ... }: {
  imports = [
    ./nvidia.nix
  ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Services
  services = {
    # Flatpak (packages managed via Home Manager)
    flatpak.enable = true;

    # X11 and GNOME
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "intl";
      };
    };
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    # Audio with PipeWire
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Printing (disabled - not using printer)
    printing.enable = false;
  };

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Environment
  environment = {
    # Environment variables for Hyprland + NVIDIA
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
      # Steam Big Picture - force Vulkan rendering
      STEAM_ENABLE_VULKAN_BIG_PICTURE = "1";
    };

    # Cedilla support ('c → ç instead of ć)
    # mkForce to override GNOME's default ibus
    variables = {
      GTK_IM_MODULE = lib.mkForce "cedilla";
      QT_IM_MODULE = lib.mkForce "cedilla";
    };

    # System packages
    systemPackages = with pkgs; [
      git
      vim
      # GNOME extensions
      gnomeExtensions.dash-to-dock
      gnomeExtensions.blur-my-shell
      # Hyprland utilities
      wl-clipboard
      grim
      slurp
    ];

    # GNOME configuration - Remove bloatware
    gnome.excludePackages = with pkgs; [
      nautilus            # File manager (using Thunar)
      # Media apps
      cheese              # Webcam
      epiphany            # Web browser
      geary               # Email client
      gnome-music         # Music player
      totem               # Video player

      # Utility apps
      gnome-tour          # Welcome tour
      gnome-contacts      # Contacts manager
      gnome-maps          # Maps
      gnome-weather       # Weather
      gnome-clocks        # Clocks/timers
      gnome-characters    # Character map
      #gnome-logs          # System logs viewer
      gnome-font-viewer   # Font viewer
      simple-scan         # Scanner
      yelp                # Help viewer
      evince              # PDF viewer (use your own)
      snapshot            # Camera app
      gnome-connections   # Remote desktop viewer
      gnome-system-monitor # System monitor (use btop)
      gnome-text-editor   # Text editor (use vim)
      gnome-terminal      # Terminal (use kitty)
      gnome-console       # Console (alternative terminal)
      baobab              # Disk usage analyzer
      gnome-software      # Software center (use nix)
      seahorse            # Passwords and Keys (GnuPG/SSH key manager)

      # Games
      gnome-chess
      gnome-mahjongg
      gnome-mines
      gnome-sudoku
      gnome-tetravex
      aisleriot           # Solitaire
      atomix
      five-or-more
      four-in-a-row
      hitori
      iagno
      lightsoff
      quadrapassel
      swell-foop
      tali
    ];
  };

  # XDG portal for Hyprland
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  # Security - PAM services
  security = {
    # GNOME Keyring - auto-unlock on login (fixes Zed auth popup)
    pam.services = {
      gdm.enableGnomeKeyring = true;
      login.enableGnomeKeyring = true;
      # Hyprlock PAM (no delay on auth)
      hyprlock.nodelay = true;
    };
    rtkit.enable = true;
  };

  # Steam with controller support
  programs.steam.enable = true;
}
