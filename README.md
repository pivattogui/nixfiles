# nixfiles

Cross-platform Nix configuration for macOS and NixOS, managed with [Nix flakes](https://nixos.wiki/wiki/Flakes), [nix-darwin](https://github.com/LnL7/nix-darwin), and [Home Manager](https://github.com/nix-community/home-manager).

## Hosts

| Host | Platform | Description |
|------|----------|-------------|
| `moka` | macOS (Apple Silicon) | Personal MacBook |
| `clinia` | macOS (Apple Silicon) | Work MacBook |
| `nixos` | NixOS | Desktop with Hyprland + Caelestia |

## Layout

```text
.
├── flake.nix           # Entry point with all hosts
├── lib/mksystem.nix    # Builder: routes to darwinSystem or nixosSystem
├── hosts/<name>/       # Host-specific settings (hardware, Dock, modules)
├── users/<profile>/    # Per-user Home Manager configuration
├── modules/
│   ├── home-common.nix # Cross-platform HM imports
│   ├── system/darwin/  # macOS defaults (Dock, Finder, Touch ID)
│   ├── system/nixos/   # NixOS config (Hyprland, PipeWire, NVIDIA)
│   └── system/fonts/   # Shared font configuration
└── pkgs/
    ├── *.nix           # Cross-platform modules (zsh, git, kitty, ...)
    └── nixos/          # NixOS-only modules (hyprland, caelestia)
```

## NixOS Desktop

The NixOS host runs Hyprland with the [Caelestia](https://github.com/caelestia-shell/shell) ecosystem:

- **Shell**: Bar, launcher, notifications, sidebar, control center
- **Theming**: Dynamic colorschemes from wallpapers
- **Lock screen**: Integrated via `caelestia-shell ipc call lock lock`
- **Session**: Power menu, logout, etc.

GUI apps are managed via Flatpak (configured in Home Manager with [nix-flatpak](https://github.com/gmodena/nix-flatpak)).

## Commands

Platform-aware aliases (auto-detect Darwin vs NixOS):

| Command | Description |
|---------|-------------|
| `rb-lint` | Static analysis (statix + deadnix) |
| `rb-fmt` | Format code (alejandra) |
| `rb-check` | Validate flake syntax |
| `rb-build` | Dry-run build with package diff |
| `rb` | Build + diff + confirm + switch |
| `rb-rollback` | Rollback to previous generation (NixOS) |
| `nix-clear` | Clean old generations (keeps 5, last 7 days) |

### Manual rebuild

```bash
# macOS
sudo darwin-rebuild switch --flake /private/etc/nix-darwin#moka

# NixOS
sudo nixos-rebuild switch --flake ~/code/nixfiles#nixos
```

## Bootstrapping

### macOS

```bash
# Install Nix with flakes
curl -L https://nixos.org/nix/install | sh

# Clone and rebuild
sudo git clone git@github.com:pivattogui/nixfiles.git /private/etc/nix-darwin
cd /private/etc/nix-darwin
sudo darwin-rebuild switch --flake .#moka
```

### NixOS

```bash
git clone git@github.com:pivattogui/nixfiles.git ~/code/nixfiles
cd ~/code/nixfiles
sudo nixos-rebuild switch --flake .#nixos
```

## Adding software

| Type | macOS | NixOS |
|------|-------|-------|
| CLI tools | `home.packages` or `pkgs/*.nix` | Same |
| GUI apps | `homebrew.casks` | Flatpak in `home.nix` or nixpkgs |
| System packages | Host module or `modules/` | Same |

## License

MIT
