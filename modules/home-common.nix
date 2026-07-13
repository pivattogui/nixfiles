{
  user,
  pkgs,
  ...
}: {
  imports = [
    ../pkgs/zsh.nix
    ../pkgs/1password.nix
    ../pkgs/git.nix
    ../pkgs/ghostty.nix
    ../pkgs/nvim.nix
    ../pkgs/zed.nix
    ../pkgs/bat.nix
    ../pkgs/claude.nix
  ];

  xdg.enable = true;

  programs.git.settings.user.email = user.git-email;

  home.stateVersion = "26.05";
}
