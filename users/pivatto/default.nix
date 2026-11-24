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
    "worktrunk"
    "opencode"
  ];

  homebrew.casks = [
    "1password"
    "ghostty"
    "obsidian"
    "zed"
    "caffeine"
    "spotify"
    "zen"
    "discord"
    "whatsapp"
    "keyboardcleantool"
    "github"
    "orbstack"
    "tailscale-app"
    "tableplus"
    "proton-mail"
    "protonvpn"
    "steam"
    "prismlauncher"
    "bruno"
    "obs"
    "transmission"
    "codex-app"
    "helium-browser"
    "superwhisper"
    "drawio"
    "photocraft"
    "granola"
    "dbeaver-community"
    "pcsx2"
  ];
}
