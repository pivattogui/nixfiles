{ user, pkgs, ... }: {
  imports = [
    ../pkgs/common-cli.nix
    ../pkgs/zsh.nix
    ../pkgs/1password.nix
    ../pkgs/git.nix
    ../pkgs/kitty.nix
    ../pkgs/vim.nix
    ../pkgs/zed.nix
    ../pkgs/claude.nix
  ];

  xdg.enable = true;

  programs.git.settings.user.email = user.git-email;

  home.packages = with pkgs; [
    # Nix tooling
    nh
    statix
    deadnix
    alejandra
  ];

  home.stateVersion = "26.05";
}
