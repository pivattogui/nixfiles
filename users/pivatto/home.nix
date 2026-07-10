{pkgs, ...}: {
  imports = [
    ../../modules/home-common.nix
  ];

  home.packages = with pkgs; [
    _1password-cli
    gh
    unzip
    fzf
    btop
    eza
    tig
    bun
    ncdu
    ripgrep
    fd
    tldr
    jq
    ffmpeg
    gh-dash
    watch
    lazygit
    nh
    statix
    deadnix
    alejandra
    lazydocker
    yazi
    unrar
    nmap
    beamPackages.elixir
  ];
}
