{ pkgs, ... }: {
  imports = [
    ./nvidia.nix
  ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # X11 and GNOME
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Keyboard layout
  services.xserver.xkb = {
    layout = "us";
    variant = "intl";
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

  # System packages
  environment.systemPackages = with pkgs; [
    git
    vim
    # GNOME extensions
    gnomeExtensions.dash-to-dock
    gnomeExtensions.blur-my-shell
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
    gnome-logs          # System logs viewer
    gnome-font-viewer   # Font viewer
    simple-scan         # Scanner
    yelp                # Help viewer
    evince              # PDF viewer (use your own)
    gnome-calculator    # Calculator
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
