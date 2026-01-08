{ config, pkgs, ... }: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;

    terminal = "${pkgs.kitty}/bin/kitty";

    extraConfig = {
      modi = "drun,run";
      show-icons = true;
      icon-theme = "Adwaita";
      drun-display-format = "{name}";
      disable-history = false;
      display-drun = "";
      matching = "fuzzy";
      sort = true;
      sorting-method = "fzf";
    };

    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        font = "JetBrains Mono 13";
        background = mkLiteral "rgba(18, 18, 18, 0.9)";
        background-alt = mkLiteral "#1a1a1a";
        foreground = mkLiteral "#e0e0e0";
        selected = mkLiteral "rgba(255, 255, 255, 0.15)";
        active = mkLiteral "#ffffff";
        urgent = mkLiteral "#f38ba8";
      };

      "window" = {
        width = mkLiteral "600px";
        padding = mkLiteral "0px";
        border = mkLiteral "1px solid";
        border-color = mkLiteral "#555555";
        border-radius = mkLiteral "12px";
        background-color = mkLiteral "@background";
        location = mkLiteral "center";
        anchor = mkLiteral "center";
      };

      "mainbox" = {
        background-color = mkLiteral "transparent";
        children = map mkLiteral [ "inputbar" "listview" ];
      };

      "inputbar" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground";
        padding = mkLiteral "16px 20px";
        children = map mkLiteral [ "prompt" "entry" ];
      };

      "prompt" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground";
        padding = mkLiteral "0px 12px 0px 0px";
      };

      "entry" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground";
        placeholder = "Search...";
        placeholder-color = mkLiteral "#a0a0a0";
      };

      "listview" = {
        background-color = mkLiteral "transparent";
        columns = 1;
        lines = 8;
        cycle = false;
        dynamic = true;
        scrollbar = false;
        layout = mkLiteral "vertical";
        padding = mkLiteral "0px 8px 8px 8px";
      };

      "element" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground";
        padding = mkLiteral "10px 16px";
        border-radius = mkLiteral "8px";
        spacing = mkLiteral "12px";
      };

      "element selected" = {
        background-color = mkLiteral "@selected";
        text-color = mkLiteral "@foreground";
      };

      "element-icon" = {
        size = mkLiteral "24px";
        background-color = mkLiteral "transparent";
      };

      "element-text" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
      };
    };
  };
}
