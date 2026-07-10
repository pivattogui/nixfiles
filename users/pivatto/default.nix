{
  config,
  pkgs,
  user,
  ...
}: {
  imports = [
    ../../modules/system/darwin/user.nix
  ];

  home-manager.users."${user.login}" = import ./home.nix {inherit config pkgs user;};

  homebrew.brews = [
    "asdf"
    "rtk"
    "worktrunk"
  ];

  homebrew.casks = [
    "1password"
    "kitty"
    "obsidian"
    "zed"
    "caffeine"
    "logi-options+"
    "rectangle"
    "spotify"
    "zen"
    "discord"
    "whatsapp"
    "keyboardcleantool"
    "github"
    "orbstack"
    "alt-tab"
    "google-chrome"
    "tailscale-app"
    "tableplus"
    "proton-mail"
    "protonvpn"
    "steam"
    "prismlauncher"
    "bruno"
    "obs"
    "transmission"
    "moonlight"
    "codex-app"
  ];
}
