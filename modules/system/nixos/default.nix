{ pkgs, lib, ... }: {
  imports = [
    ./nvidia.nix
  ];

  # Flatpak (packages managed via Home Manager)
  services.flatpak.enable = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # X11 and GNOME
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Environment variables for Hyprland + NVIDIA
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    # Steam Big Picture - force Vulkan rendering
    STEAM_ENABLE_VULKAN_BIG_PICTURE = "1";
  };

  # Cedilla support ('c → ç instead of ć)
  # mkForce to override GNOME's default ibus
  environment.variables = {
    GTK_IM_MODULE = lib.mkForce "cedilla";
    QT_IM_MODULE = lib.mkForce "cedilla";
  };

  # XDG portal for Hyprland
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  # Keyboard layout
  services.xserver.xkb = {
    layout = "us";
    variant = "intl";
  };

  # GNOME Keyring - auto-unlock on login (fixes Zed auth popup)
  security.pam.services.gdm.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;

  # Hyprlock PAM (no delay on auth)
  security.pam.services.hyprlock = {
    nodelay = true;
  };

  # Audio with PipeWire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Printing (disabled - not using printer)
  services.printing.enable = false;

  # Steam with controller support
  programs.steam.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
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
  environment.gnome.excludePackages = with pkgs; [
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
}
