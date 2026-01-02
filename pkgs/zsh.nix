{ pkgs, ... }:
let
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  programs.zsh = {
    enable = true;
    # With stateVersion >= 26.05, dotDir defaults to ".config/zsh"
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "fzf"
      ];
      theme = "arrow";
    };
    shellAliases = {
      ll = "ls -alF";
      nix-clear = "nix-collect-garbage -d";
      tree = "eza -T";
      code = "zed";
    } // (if isDarwin then {
      nix-config = "zed /etc/nix-darwin";
      rb = "sudo darwin-rebuild switch --flake /private/etc/nix-darwin";
      uuid = "uuidgen | tr '[:upper:]' '[:lower:]' | tr -d '\n' | pbcopy | echo 'UUID copied to clipboard'";
    } else {
      nix-config = "zed ~/code/nixfiles";
      rb = "sudo nixos-rebuild switch --flake ~/code/nixfiles#nixos";
      uuid = "uuidgen | tr '[:upper:]' '[:lower:]' | tr -d '\n' | xclip -selection clipboard && echo 'UUID copied to clipboard'";
    });
    # asdf-vm 0.18+ binary works from PATH, but shims still need to be added
    initContent = ''
      export PATH="$HOME/.asdf/shims:$PATH"
    '' + (if isDarwin then "" else ''
      export UV_PYTHON_PREFERENCE=only-system
    '');
  };
}
