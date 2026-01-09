{ pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
  flake = if isDarwin then "/private/etc/nix-darwin" else "~/code/nixfiles";
  nhCmd = if isDarwin then "nh darwin" else "nh os";
in
{
  programs.zsh = {
    enable = true;
    # With stateVersion >= 26.05, dotDir defaults to ".config/zsh"
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "fzf" ];
      theme = "arrow";
    };
    shellAliases = {
      ll = "ls -alF";
      tree = "eza -T";
      code = "zed";

      # Nix cleanup
      nix-clear = "nh clean all --keep 5 --keep-since 7d";

      # Code analysis
      rb-lint = "statix check ${flake} && deadnix ${flake}";
      rb-fmt = "alejandra ${flake}";

      # Validation
      rb-check = "nix flake check ${flake}";
      rb-build = "${nhCmd} switch ${flake} --dry -d always";

      # Safe rebuild (recommended)
      rb = "${nhCmd} switch ${flake} -a -d always";

      # Escape hatch
      rb-force = if isDarwin
        then "sudo darwin-rebuild switch --flake ${flake}"
        else "sudo nixos-rebuild switch --flake ${flake}#nixos";
    } // (if isDarwin then {
      nix-config = "zed /etc/nix-darwin";
      uuid = "uuidgen | tr '[:upper:]' '[:lower:]' | tr -d '\\n' | pbcopy | echo 'UUID copied'";
    } else {
      nix-config = "zed ~/code/nixfiles";
      rb-rollback = "sudo nixos-rebuild switch --rollback";
      uuid = "uuidgen | tr '[:upper:]' '[:lower:]' | tr -d '\\n' | xclip -selection clipboard && echo 'UUID copied'";
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
