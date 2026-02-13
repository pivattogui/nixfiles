{ pkgs, lib, ... }: {
  imports = [
    ./nvidia.nix
  ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Services
  services = {
    # Bluetooth manager
    blueman.enable = true;

    # Flatpak (packages managed via Home Manager)
    flatpak.enable = true;

    # Greetd display manager
    greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };
    };

    # Audio with PipeWire
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # GNOME Keyring (standalone, without GNOME desktop)
    gnome.gnome-keyring.enable = true;

    # Printing (disabled - not using printer)
    printing.enable = false;

    # Tailscale VPN
    tailscale.enable = true;
  };

  # Tailscale: don't start automatically
  systemd.services.tailscaled.wantedBy = lib.mkForce [];

  # Flatpak fonts: expose NixOS fonts at /usr/share/fonts (FHS path)
  # Required because xdg-desktop-portal-gtk expects fonts at standard locations
  system.fsPackages = [ pkgs.bindfs ];
  fileSystems."/usr/share/fonts" = {
    device = "/run/current-system/sw/share/X11/fonts";
    fsType = "fuse.bindfs";
    options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
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

    # System packages
    systemPackages = with pkgs; [
      git
      vim
      # Hyprland utilities
      wl-clipboard
      grim
      slurp
    ];
  };

  # XDG portal for Hyprland
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
    config = {
      common = {
        default = [ "gtk" ];
      };
      Hyprland = {
        default = [ "hyprland" "gtk" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "hyprland" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "hyprland" ];
        "org.freedesktop.impl.portal.GlobalShortcuts" = [ "hyprland" ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      };
    };
  };

  # Security - PAM services
  security = {
    # GNOME Keyring - auto-unlock on login (fixes Zed auth popup)
    pam.services = {
      greetd.enableGnomeKeyring = true;
      login.enableGnomeKeyring = true;
    };
    rtkit.enable = true;
  };

  # Steam with controller support
  programs.steam.enable = true;
}
