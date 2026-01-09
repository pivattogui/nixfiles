{ pkgs, ... }:
let
  powermenu = pkgs.writeShellScriptBin "powermenu" ''
    options="󰌾 Lock\n󰗽 Logout\n󰜉 Suspend\n󰑓 Reboot\n󰐥 Shutdown"
    
    selected=$(echo -e "$options" | ${pkgs.fuzzel}/bin/fuzzel --dmenu --prompt "Power: " --width 20 --lines 5)
    
    case "$selected" in
      "󰌾 Lock") hyprlock ;;
      "󰗽 Logout") hyprctl dispatch exit ;;
      "󰜉 Suspend") systemctl suspend ;;
      "󰑓 Reboot") systemctl reboot ;;
      "󰐥 Shutdown") systemctl poweroff ;;
    esac
  '';
in {
  home.packages = [ pkgs.fuzzel powermenu ];

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "JetBrains Mono:size=13";
        terminal = "kitty";
        layer = "overlay";
        prompt = "❯ ";
      };
      colors = {
        background = "121212ee";
        text = "e0e0e0ff";
        selection = "ffffff26";
        selection-text = "ffffffff";
        border = "555555ff";
      };
      border = {
        width = 2;
        radius = 12;
      };
    };
  };
}
