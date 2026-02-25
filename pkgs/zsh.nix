{ pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
  flake = if isDarwin then "~/Code/nixfiles" else "~/code/nixfiles";
  nhCmd = if isDarwin then "nh darwin" else "nh os";
in
{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "fzf" ];
      theme = "arrow";
    };
    shellAliases = {
      ll = "ls -alF";
      tree = "eza -T";

      nix-clear = "nh clean all --keep 5 --keep-since 7d";

      rb-lint = "statix check ${flake} && deadnix ${flake}";
      rb-fmt = "alejandra ${flake}";
      rb-check = "nix flake check ${flake}";
      rb-build = "${nhCmd} switch ${flake} --dry -d always";
      rb = "${nhCmd} switch ${flake} -a -d always";

    } // (if isDarwin then {
      nix-config = "zed ~/code/nixfiles";
      code = "zed";
      uuid = "uuidgen | tr '[:upper:]' '[:lower:]' | tr -d '\\n' | pbcopy | echo 'UUID copied'";
    } else {
      nix-config = "zeditor ~/code/nixfiles";
      code = "zeditor";
      zed = "zeditor";
      rb-rollback = "sudo nixos-rebuild switch --rollback";
      uuid = "uuidgen | tr '[:upper:]' '[:lower:]' | tr -d '\\n' | xclip -selection clipboard && echo 'UUID copied'";
      ts-up = "sudo systemctl start tailscaled && sudo tailscale up";
      ts-down = "tailscale down && sudo systemctl stop tailscaled";
    });
    # asdf-vm 0.18+ binary works from PATH, but shims still need to be added
    initContent = ''
      export PATH="$HOME/.asdf/shims:$PATH"
    '' + (if isDarwin then "" else ''
      export UV_PYTHON_PREFERENCE=only-system
      # Load wallust-generated shell colors (LS_COLORS, EZA_COLORS)
      [[ -f "$HOME/.config/shell/colors.sh" ]] && source "$HOME/.config/shell/colors.sh"
    '');
  };
}
