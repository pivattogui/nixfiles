{ pkgs, ... }: {
  home.packages = [ pkgs.swaynotificationcenter ];

  xdg.configFile."swaync/config.json".text = builtins.toJSON {
    positionX = "right";
    positionY = "top";
    control-center-width = 400;
    control-center-height = 600;
    fit-to-screen = false;
    layer = "overlay";
    cssPriority = "user";
    notification-icon-size = 48;
    notification-body-image-height = 100;
    notification-body-image-width = 200;
    timeout = 10;
    timeout-low = 5;
    timeout-critical = 0;
    notification-window-width = 350;
    keyboard-shortcuts = true;
    image-visibility = "when-available";
    transition-time = 200;
    hide-on-clear = true;
    hide-on-action = true;
    widgets = [
      "title"
      "dnd"
      "notifications"
    ];
    widget-config = {
      title = {
        text = "Notifications";
        clear-all-button = true;
      };
      dnd = {
        text = "Do Not Disturb";
      };
    };
  };

  xdg.configFile."swaync/style.css".text = ''
    * {
      font-family: "JetBrains Mono";
      font-size: 13px;
    }

    .control-center {
      background: rgba(18, 18, 18, 0.95);
      border: 1px solid #555555;
      border-radius: 12px;
      padding: 12px;
    }

    .notification {
      background: #1a1a1a;
      border: 1px solid #555555;
      border-radius: 8px;
      margin: 6px;
      padding: 12px;
    }

    .notification-content {
      color: #e0e0e0;
    }

    .notification .summary {
      color: #ffffff;
      font-weight: bold;
    }

    .notification .body {
      color: #a0a0a0;
    }

    .notification.critical {
      border-color: #f38ba8;
    }

    .widget-title {
      color: #e0e0e0;
      font-weight: bold;
      padding: 8px;
    }

    .widget-title > button {
      background: #2a2a2a;
      color: #e0e0e0;
      border: none;
      border-radius: 6px;
      padding: 4px 12px;
    }

    .widget-title > button:hover {
      background: #3a3a3a;
    }

    .widget-dnd {
      color: #e0e0e0;
      padding: 8px;
    }

    .widget-dnd > switch {
      background: #2a2a2a;
      border-radius: 12px;
    }

    .widget-dnd > switch:checked {
      background: #555555;
    }

    .widget-dnd > switch slider {
      background: #e0e0e0;
      border-radius: 50%;
    }
  '';
}
