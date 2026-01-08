{ pkgs, ... }: {
  imports = [
    ../../modules/home-common.nix
  ];

  home.packages = with pkgs; [
    lazydocker
    yazi
    elixir
  ];
}
