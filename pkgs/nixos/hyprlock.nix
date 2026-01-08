{ pkgs, self, ... }:
let
  wallpaper = "${self}/assets/wallpaper.jpg";
in {
  home.packages = [ pkgs.hyprlock ];

  xdg.configFile."hypr/hyprlock.conf".text = ''
    general {
      hide_cursor = true
      grace = 0
      immediate_render = true
      ignore_empty_input = true
    }

    background {
      path = ${wallpaper}
      blur_passes = 2
      blur_size = 6
      brightness = 0.3
    }

    input-field {
      size = 300, 50
      outline_thickness = 2
      dots_size = 0.25
      dots_spacing = 0.3
      outer_color = rgb(85, 85, 85)
      inner_color = rgb(26, 26, 26)
      font_color = rgb(224, 224, 224)
      check_color = rgb(160, 160, 160)
      fail_color = rgb(200, 200, 200)
      fail_text = <i>Wrong password</i>
      fail_timeout = 2000
      fail_transition = 300
      capslock_color = rgb(120, 120, 120)
      numlock_color = rgb(120, 120, 120)
      bothlock_color = rgb(120, 120, 120)
      fade_on_empty = true
      placeholder_text = <i>Password...</i>
      hide_input = false
      rounding = 8
      position = 0, -50
      halign = center
      valign = center
    }

    label {
      text = $TIME
      color = rgba(224, 224, 224, 1.0)
      font_size = 72
      font_family = JetBrains Mono
      position = 0, 100
      halign = center
      valign = center
    }

    label {
      text = cmd[update:1000] date +"%A, %d de %B"
      color = rgba(160, 160, 160, 1.0)
      font_size = 16
      font_family = JetBrains Mono
      position = 0, 40
      halign = center
      valign = center
    }
  '';
}
