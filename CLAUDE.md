# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal nix-darwin configuration repository managing macOS environments using Nix flakes, nix-darwin, and Home Manager. The configuration supports multiple hosts (`moka` for personal, `clinia` for work) with per-user settings and shared modules.

## Common Commands

### Rebuilding the System
```bash
# Rebuild for the current host (using alias defined in pkgs/zsh.nix)
rb

# Rebuild for a specific host
sudo darwin-rebuild switch --flake /private/etc/nix-darwin#moka
sudo darwin-rebuild switch --flake /private/etc/nix-darwin#clinia

# Rebuild from the current directory
sudo darwin-rebuild switch --flake .#moka
```

### Maintenance
```bash
# Update flake inputs (nixpkgs, home-manager, nix-darwin)
nix flake update

# Clean up old generations
nix-clear  # alias for: nix-collect-garbage -d

# Open config in Zed editor
nix-config  # alias for: zed /etc/nix-darwin
```

## Architecture

### Multi-Host System Builder (`lib/mksystem.nix`)

The `mkSystem` helper function is the core abstraction that instantiates nix-darwin systems. It accepts:
- `name`: Host name (e.g., "moka", "clinia")
- `system`: Architecture (e.g., "aarch64-darwin")
- `user`: User configuration with `login`, `git-email`, and optional `profile`

Key behavior:
- If `user.profile` is set, loads user config from `users/${profile}/`, otherwise uses `users/${login}/`
- Automatically imports host-specific config from `hosts/${name}/`
- Passes user attributes to all modules via `specialArgs`
- Enables unfree packages and flakes by default

### Configuration Layers

1. **Host Layer** (`hosts/`)
   - Defines host-specific settings like Dock layout
   - Imports shared system modules (darwin defaults, fonts)
   - Sets `system.stateVersion` and `configurationRevision`

2. **User Layer** (`users/`)
   - `default.nix`: Wires Home Manager into nix-darwin, configures Homebrew casks
   - `home.nix`: Imports reusable modules from `pkgs/`, declares Nix packages
   - User email is set via `programs.git.settings.user.email = user.git-email`

3. **Shared Modules** (`modules/`)
   - `system/darwin`: macOS defaults (Touch ID for sudo, Dock behavior, Finder settings, hot corners)
   - `system/fonts`: Font packages managed by Nix

4. **Reusable Profiles** (`pkgs/`)
   - Self-contained program configurations (zsh, git, kitty, 1password, vim)
   - Imported by users as needed in their `home.nix`

### Adding New Software

- **System packages**: Add to `environment.systemPackages` in host config
- **GUI applications**: Add to `homebrew.casks` in user's `default.nix`
- **CLI tools**: Add to `home.packages` in user's `home.nix`
- **New programs**: Create module in `pkgs/` and import in user's `home.nix`

### Adding a New Host

1. Create `hosts/<name>/default.nix` with host-specific settings
2. Register in `flake.nix` under `darwinConfigurations.<name>`
3. Specify `system` architecture and `user` attributes

### Adding a New User

1. Create `users/<username>/default.nix` (homebrew + home-manager setup)
2. Create `users/<username>/home.nix` (packages + module imports)
3. Reference in a host configuration in `flake.nix`

## Important Configuration Details

- **Git Signing**: Uses SSH signing via 1Password (`gpg.ssh.program` points to 1Password's op-ssh-sign)
- **Homebrew**: Auto-updates and cleans up on activation (see `homebrew.onActivation` in user configs)
- **Home Manager**: Backup files use `.hm-bak` extension to avoid conflicts
- **ZSH**: Configured with Oh My Zsh, theme "arrow", asdf-vm initialization
