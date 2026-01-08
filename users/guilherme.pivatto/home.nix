{ pkgs, ... }: {
  imports = [
    ../../modules/home-common.nix
  ];

  home.packages = with pkgs; [
    docker
    tree
    pscale
    ngrok
    go
    kubectl
  ];
}
