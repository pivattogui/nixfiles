{ pkgs, ... }: {
  imports = [
    ../../modules/home-common.nix
    ../../pkgs/xcompose.nix
    ../../pkgs/nixos/hyprland.nix
    ../../pkgs/nixos/caelestia.nix
    ../../pkgs/nixos/spicetify.nix
  ];

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  home.sessionVariables = {
    XDG_DATA_DIRS = "$HOME/.local/share\${XDG_DATA_DIRS:+:}$XDG_DATA_DIRS";
  };

  home.packages = with pkgs; [
    nodejs
    python3
    zed-editor
    lutris
    nautilus
    obsidian
    _1password-gui
    docker
    pavucontrol
    google-chrome
    prismlauncher
    libnotify
    playerctl
    swww
    cava
    fastfetch
    obs-studio
    vlc
    gnome-logs
    claude-code
    xdg-desktop-portal-gtk
    qgnomeplatform-qt6
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  services.flatpak.remotes = [{
    name = "flathub";
    location = "https://flathub.org/repo/flathub.flatpakrepo";
  }];

  services.flatpak.packages = [
    "app.zen_browser.zen"
    "com.heroicgameslauncher.hgl"
    "com.stremio.Stremio"
    "io.github.flattool.Warehouse"
    "io.podman_desktop.PodmanDesktop"
    "com.discordapp.Discord"
  ];

  # Flatpak overrides: give access to /nix/store so apps can follow font symlinks
  services.flatpak.overrides = {
    global = {
      Context.filesystems = [
        "/nix/store:ro"
      ];
    };
  };
}
