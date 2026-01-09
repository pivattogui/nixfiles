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

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "pulseaudio" "network" "custom/notification" "tray" "clock" ];

        "custom/notification" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            notification = "󰂚";
            none = "󰂜";
            dnd-notification = "󰂛";
            dnd-none = "󰪑";
          };
          return-type = "json";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };

        "hyprland/workspaces" = {
          format = "{name}";
          on-click = "activate";
        };

        "hyprland/window" = {
          max-length = 50;
          separate-outputs = true;
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
        font-family: "Inter";
        font-size: 13px;
        font-weight: 600;
      }

      window#waybar {
        background-color: rgba(18, 18, 18, 0.85);
        color: #e0e0e0;
      }

      #workspaces {
        margin-left: 8px;
      }

      #workspaces button {
        padding: 0 8px;
        color: #a0a0a0;
        background: transparent;
        border: none;
        border-radius: 0;
      }

      #workspaces button:hover {
        color: #e0e0e0;
        background: rgba(255, 255, 255, 0.1);
      }

      #workspaces button.active {
        color: #ffffff;
        background: rgba(255, 255, 255, 0.15);
      }

      #window {
        color: #a0a0a0;
        padding: 0 12px;
      }

      #clock, #network, #pulseaudio, #custom-notification, #tray {
        padding: 0 12px;
        color: #e0e0e0;
      }

      #clock {
        margin-right: 8px;
      }

      #network, #pulseaudio {
        font-size: 14px;
      }

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
