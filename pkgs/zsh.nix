{ pkgs, config, ... }:
let
  flake = "~/Code/nixfiles";
  nhCmd = "nh darwin";
in
{
  programs.zsh = {
    enable = true;
    history = {
      path = "${config.home.homeDirectory}/.zsh_history";
      size = 50000;
      save = 50000;
      share = true;
      extended = true;
      ignoreDups = true;
      ignoreSpace = true;
    };
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

      nix-config = "zed ~/code/nixfiles";
      code = "zed";
      uuid = "uuidgen | tr '[:upper:]' '[:lower:]' | tr -d '\\n' | pbcopy | echo 'UUID copied'";
    };
    initContent = ''
      export PATH="$HOME/.asdf/shims:$PATH"
      export PATH=$HOME/.local/bin:$PATH
      export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
    '';
  };
}
