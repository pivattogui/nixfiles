{ pkgs, ... }:
let
  iconsPath = "/home/pivattogui/code/nixfiles/assets/wlogout";
in {
  home.packages = [ pkgs.wlogout ];

  xdg.configFile."wlogout/layout".text = ''
    {
      "label" : "lock",
      "action" : "hyprlock",
      "text" : "Lock",
      "keybind" : "l"
    }
    {
      "label" : "logout",
      "action" : "hyprctl dispatch exit",
      "text" : "Logout",
      "keybind" : "e"
    }
    {
      "label" : "suspend",
      "action" : "systemctl suspend",
      "text" : "Suspend",
      "keybind" : "u"
    }
    {
      "label" : "hibernate",
      "action" : "systemctl hibernate",
      "text" : "Hibernate",
      "keybind" : "h"
    }
    {
      "label" : "reboot",
      "action" : "systemctl reboot",
      "text" : "Reboot",
      "keybind" : "r"
    }
    {
      "label" : "shutdown",
      "action" : "systemctl poweroff",
      "text" : "Shutdown",
      "keybind" : "s"
    }
  '';

  xdg.configFile."wlogout/style.css".text = ''
    * {
      background-image: none;
      font-family: "JetBrains Mono";
    }

    window {
      background-color: rgba(0, 0, 0, 0.85);
    }

    button {
      color: #e0e0e0;
      background-color: #1a1a1a;
      border: 2px solid #555555;
      border-radius: 12px;
      margin: 10px;
      font-size: 16px;
      background-repeat: no-repeat;
      background-position: center;
      background-size: 25%;
    }

    button:hover {
      background-color: #3a3a3a;
      border-color: #e0e0e0;
    }

    button:focus {
      background-color: #4a4a4a;
      border-color: #e0e0e0;
    }

    #lock {
      background-image: url("${iconsPath}/lock.png");
    }

    #logout {
      background-image: url("${iconsPath}/logout.png");
    }

    #suspend {
      background-image: url("${iconsPath}/suspend.png");
    }

    #hibernate {
      background-image: url("${iconsPath}/hibernate.png");
    }

    #reboot {
      background-image: url("${iconsPath}/reboot.png");
    }

    #shutdown {
      background-image: url("${iconsPath}/shutdown.png");
    }
  '';
}
