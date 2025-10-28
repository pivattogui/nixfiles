# nix-darwin dotfiles

macOS configuration managed with [Nix flakes](https://nixos.wiki/wiki/Flakes), [nix-darwin](https://github.com/LnL7/nix-darwin), and [Home Manager](https://github.com/nix-community/home-manager). The flake reproduces the environments for the `moka` (personal) and `clinia` (work) hosts, keeping system packages, Homebrew apps, and macOS defaults in a single versioned source of truth.

## Layout

```text
.
├── flake.nix        # Flake entry point with all defined hosts
├── hosts/           # Host-specific settings (Dock, imported modules, ...)
├── users/           # Per-user configuration via Home Manager
├── modules/         # Shared nix-darwin modules (macOS defaults, fonts, ...)
├── pkgs/            # Reusable program/profile modules
└── lib/mksystem.nix # Helper that instantiates nix-darwin systems
```

### Hosts (`hosts/`)
Each host imports shared modules and sets host-only preferences such as Dock layout. To add a new machine, create `hosts/<name>/default.nix` and register it in `flake.nix`.

### Users (`users/`)
User modules enable Home Manager, configure Homebrew apps, and pull in reusable modules from `pkgs/`. The `home.nix` files describe user packages, while `default.nix` wires Home Manager into nix-darwin.

### Modules & packages (`modules/`, `pkgs/`)
- `modules/system/darwin`: global defaults (Dock tweaks, Finder options, Touch ID for sudo, ...).
- `modules/system/fonts`: fonts managed by Nix (`jetbrains-mono`).
- `pkgs/zsh.nix`: default shell using Oh My Zsh, aliases, and plugins.
- `pkgs/1password.nix`: integrates the 1Password SSH agent.
- `pkgs/git.nix`: opinionated Git setup with SSH signing via 1Password.
- `pkgs/kitty.nix`: Kitty theme, key bindings, and UI preferences.

## Prerequisites

1. Install [Nix with flakes enabled](https://nixos.org/download.html).
2. Install `nix-darwin` (requires Xcode Command Line Tools).
3. Optionally keep `/private/etc/nix-darwin` under version control.

## Bootstrapping a new machine

```bash
# 1. Clone the repository
sudo git clone git@github.com:your-user/dotfiles.git /private/etc/nix-darwin
cd /private/etc/nix-darwin

# 2. Rebuild for the desired host
sudo darwin-rebuild switch --flake .#moka
# or
sudo darwin-rebuild switch --flake .#clinia
```

Switch the host or user by editing `flake.nix`. The `rb` alias (defined in `pkgs/zsh.nix`) runs `sudo darwin-rebuild switch --flake /private/etc/nix-darwin` for convenience.

## Tips & maintenance

- `nix-config`: opens the config folder in Zed.
- `nix-clear`: runs `nix-collect-garbage -d` to free store space.
- Refresh inputs with `nix flake update` to update `flake.lock`.
- When adding software:
  - System packages → add them in `modules` or the relevant host.
  - GUI apps → add them to `homebrew.casks`.
  - CLI tools → add them to `home.packages` or create a module in `pkgs/`.

## License

Released under the MIT License. See `LICENSE` for details.
