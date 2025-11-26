{ config, pkgs, user, ... }: {
  imports = [
    ../../pkgs/common-cli.nix
    ../../pkgs/zsh.nix
    ../../pkgs/1password.nix
    ../../pkgs/git.nix
    ../../pkgs/kitty.nix
    ../../pkgs/vim.nix
  ];

  xdg.enable = true;

  # User-specific packages
  home.packages = with pkgs; [
    lazydocker
    yazi
    elixir
    claude-code
  ];

  programs.git.settings.user.email = user.git-email;

  home.stateVersion = "25.05";
}
