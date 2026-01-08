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
        frame_color = "#555555";
        corner_radius = 8;

        separator_height = 2;
        separator_color = "#2a2a2a";
        padding = 12;
        horizontal_padding = 12;

        icon_position = "left";
        max_icon_size = 48;

        background = "#1a1a1a";
        foreground = "#e0e0e0";
      };

      urgency_low = {
        background = "#1a1a1a";
        foreground = "#a0a0a0";
        frame_color = "#555555";
        timeout = 5;
      };

      urgency_normal = {
        background = "#1a1a1a";
        foreground = "#e0e0e0";
        frame_color = "#555555";
        timeout = 10;
      };

      urgency_critical = {
        background = "#1a1a1a";
        foreground = "#e0e0e0";
        frame_color = "#f38ba8";
        timeout = 0;
      };
    };
  };
}
