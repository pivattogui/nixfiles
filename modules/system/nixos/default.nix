{ pkgs, lib, ... }: {
  imports = [
    ./nvidia.nix
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
        ControllerMode = "dual";
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  services = {
    blueman.enable = true;
    flatpak.enable = true;

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "where-is-my-sddm-theme";
    };

    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber = {
        enable = true;
        extraConfig = {
          "10-bluez" = {
            "monitor.bluez.properties" = {
              "bluez5.enable-sbc-xq" = true;
              "bluez5.enable-msbc" = true;
              "bluez5.enable-hw-volume" = false;
              "bluez5.headset-roles" = [ ];
              "bluez5.hfphsp-backend" = "none";
            };
            "monitor.bluez.rules" = [
              {
                matches = [{ "device.name" = "~bluez_card.*"; }];
                actions = {
                  update-props = {
                    "bluez5.auto-connect" = [ "a2dp_sink" "a2dp_source" ];
                  };
                };
              }
            ];
          };
        };
      };
    };

    gnome.gnome-keyring.enable = true;
    printing.enable = false;
    tailscale.enable = true;
  };

  systemd.services.tailscaled.wantedBy = lib.mkForce [];

  # Flatpak fonts: expose NixOS fonts at /usr/share/fonts (FHS path)
  # Required because xdg-desktop-portal-gtk expects fonts at standard locations
  system.fsPackages = [ pkgs.bindfs ];
  fileSystems."/usr/share/fonts" = {
    device = "/run/current-system/sw/share/X11/fonts";
    fsType = "fuse.bindfs";
    options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment = {
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
      STEAM_ENABLE_VULKAN_BIG_PICTURE = "1";
    };

    # System packages
    systemPackages = with pkgs; [
      git
      vim
      wl-clipboard
      grim
      slurp
      libfreeaptx
      where-is-my-sddm-theme
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
      sddm.enableGnomeKeyring = true;
      login.enableGnomeKeyring = true;
    };
    rtkit.enable = true;
  };

  # Steam with controller support
  programs.steam.enable = true;
}
