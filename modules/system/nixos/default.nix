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

  # Printing
  services.printing.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    git
    vim
    # GNOME extensions
    gnomeExtensions.dash-to-dock
    gnomeExtensions.blur-my-shell
  ];

  # GNOME configuration
  environment.gnome.excludePackages = with pkgs; [
    # Remove unnecessary GNOME apps to keep system clean
  ];
}
