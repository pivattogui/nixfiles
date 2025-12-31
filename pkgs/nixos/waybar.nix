{ config, pkgs, ... }: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 28;
        spacing = 0;

        # Layout estilo macOS: workspaces à esquerda, clock à direita
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "mpris" "hyprland/window" ];
        modules-right = [ "pulseaudio" "network" "tray" "clock" ];

        "hyprland/workspaces" = {
          format = "{name}";
          on-click = "activate";
        };

        "hyprland/window" = {
          max-length = 50;
          separate-outputs = true;
        };

        mpris = {
          format = "{player_icon} {artist} - {title}";
          format-paused = "{player_icon} {artist} - {title}";
          player-icons = {
            default = "▶";
            spotify = "";
            firefox = "";
            chromium = "";
          };
          status-icons = {
            paused = "⏸";
          };
          max-length = 50;
        };

        clock = {
          format = "{:%a %d %b  %H:%M}";
          tooltip-format = "<tt>{calendar}</tt>";
        };

        network = {
          format-wifi = "{icon}";
          format-ethernet = "󰈀";
          format-disconnected = "󰖪";
          format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          tooltip-format-wifi = "{essid} ({signalStrength}%)";
          tooltip-format-ethernet = "{ifname}: {ipaddr}";
        };

        pulseaudio = {
          format = "{icon}";
          format-muted = "󰝟";
          format-icons = {
            default = [ "󰕿" "󰖀" "󰕾" ];
          };
          tooltip-format = "{volume}%";
          on-click = "pavucontrol";
        };

        tray = {
          spacing = 8;
          icon-size = 16;
        };
      };
    };

    style = ''
      * {
        font-family: "Inter", "JetBrainsMono Nerd Font";
        font-size: 13px;
        font-weight: 600;
      }

      window#waybar {
        background-color: rgba(0, 0, 0, 0.5);
        color: #ffffff;
      }

      /* Workspaces */
      #workspaces {
        margin-left: 8px;
      }

      #workspaces button {
        padding: 0 8px;
        color: rgba(255, 255, 255, 0.6);
        background: transparent;
        border: none;
        border-radius: 0;
      }

      #workspaces button:hover {
        color: #ffffff;
        background: rgba(255, 255, 255, 0.1);
      }

      #workspaces button.active {
        color: #ffffff;
        background: rgba(255, 255, 255, 0.15);
      }

      /* Centro - mpris e window */
      #mpris, #window {
        color: rgba(255, 255, 255, 0.8);
        padding: 0 12px;
      }

      #mpris {
        font-style: italic;
      }

      /* Módulos à direita */
      #clock, #network, #pulseaudio, #tray {
        padding: 0 12px;
        color: #ffffff;
      }

      #clock {
        margin-right: 8px;
      }

      /* Ícones um pouco maiores */
      #network, #pulseaudio {
        font-size: 14px;
      }

      /* Tray */
      #tray {
        padding: 0 8px;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
      }
    '';
  };
}
