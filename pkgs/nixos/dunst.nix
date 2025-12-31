{ config, pkgs, ... }: {
  services.dunst = {
    enable = true;

    settings = {
      global = {
        width = 350;
        height = 150;
        offset = "10x40";
        origin = "top-right";

        font = "JetBrains Mono 11";

        frame_width = 2;
        frame_color = "#89b4fa";
        corner_radius = 8;

        separator_height = 2;
        separator_color = "#585b70";
        padding = 12;
        horizontal_padding = 12;

        icon_position = "left";
        max_icon_size = 48;

        background = "#1e1e2e";
        foreground = "#cdd6f4";
      };

      urgency_low = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#89b4fa";
        timeout = 5;
      };

      urgency_normal = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#89b4fa";
        timeout = 10;
      };

      urgency_critical = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#f38ba8";
        timeout = 0;
      };
    };
  };
}
