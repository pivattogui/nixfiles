{ pkgs, ... }:
let
  wallpaperPicker = pkgs.writeShellScriptBin "wallpaper-picker" ''
    WALLPAPER_DIR="''${HOME}/Pictures/Wallpapers"

    if [ ! -d "$WALLPAPER_DIR" ]; then
      mkdir -p "$WALLPAPER_DIR"
      ${pkgs.libnotify}/bin/notify-send "Wallpaper Picker" "Created $WALLPAPER_DIR - add some wallpapers there"
      exit 0
    fi

    wallpapers=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" \) 2>/dev/null)

    if [ -z "$wallpapers" ]; then
      ${pkgs.libnotify}/bin/notify-send "Wallpaper Picker" "No wallpapers found in $WALLPAPER_DIR"
      exit 0
    fi

    entries=""
    while IFS= read -r img; do
      name=$(basename "$img")
      entries+="$name\0icon\x1f$img\n"
    done <<< "$wallpapers"

    selected=$(echo -en "$entries" | rofi -dmenu -i -p "Wallpaper" -show-icons -theme-str 'element-icon { size: 64px; }')

    if [ -n "$selected" ]; then
      full_path="$WALLPAPER_DIR/$selected"

      # Set wallpaper
      ${pkgs.swww}/bin/swww img "$full_path" --transition-type wipe --transition-duration 1

      # Generate colors from wallpaper and apply templates
      ${pkgs.wallust}/bin/wallust run "$full_path"

      # Reload Hyprland to apply new colors
      hyprctl reload

      # Reload Waybar
      pkill -SIGUSR2 waybar || true

      # Reload Kitty instances
      for pid in $(pgrep kitty); do
        kill -SIGUSR1 "$pid" 2>/dev/null || true
      done

      ${pkgs.libnotify}/bin/notify-send "Wallpaper" "Theme updated from $selected"
    fi
  '';
in {
  home.packages = [ wallpaperPicker ];
}
