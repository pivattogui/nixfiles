{ config, pkgs, user, ... }:
{
  imports = [
    ../../modules/system/darwin/user.nix
    ../../pkgs/common-casks.nix
  ];

  home-manager.users."${user.login}" = import ./home.nix { inherit config pkgs user; };

  homebrew.brews = [
    "asdf"
    "fop"
    "openssl@3"
    "unixodbc"
    "openjdk"
    "wxmac"
    "cmake"
    "cloudflared"
    "kubernetes-cli"
    "kubectx"
  ];

  homebrew.casks = [
    "dbgate"
    "redis-insight"
    "hoppscotch"
    "notion"
    "notion-calendar"
    "slack"
    "linear-linear"
    "gcloud-cli"
  ];
}
