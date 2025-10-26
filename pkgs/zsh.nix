{ ... }: {
  programs.zsh = {
      enable = true;
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
        nix-config = "zed /etc/nix-darwin";
        nix-clear = "nix-collect-garbage -d";
        rb = "sudo darwin-rebuild switch --flake /private/etc/nix-darwin";
        tree = "eza -T";
      };
    };
}
