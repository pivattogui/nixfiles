# nixfiles

macOS configuration managed with [Nix flakes](https://nixos.wiki/wiki/Flakes), [nix-darwin](https://github.com/nix-darwin/nix-darwin), and [Home Manager](https://github.com/nix-community/home-manager).

## Hosts

| Host | Architecture | User | Purpose |
|------|--------------|------|---------|
| `moka` | aarch64-darwin | `pivatto` | Personal MacBook |

## Layout

```text
.
├── flake.nix              # Entry point, declares hosts
├── lib/mksystem.nix       # darwinSystem builder
├── hosts/<name>/          # Host-specific settings (Dock, hostname)
├── users/<login>/         # Per-user Home Manager + Homebrew
├── modules/
│   ├── home-common.nix    # Base Home Manager imports
│   └── system/
│       ├── darwin/        # macOS defaults (Finder, Touch ID, user)
│       └── fonts/         # Font packages
└── pkgs/                  # Reusable program modules
    ├── zsh.nix · git.nix · ghostty.nix · vim.nix · zed.nix
    ├── 1password.nix · bat.nix · claude.nix
```

## Commands

Aliases defined in `pkgs/zsh.nix`, all targeting `~/Code/nixfiles` via [`nh`](https://github.com/nix-community/nh):

| Command | Description |
|---------|-------------|
| `rb-lint` | Static analysis (`statix` + `deadnix`) |
| `rb-fmt` | Format Nix code (`alejandra`) |
| `rb-check` | Validate flake (`nix flake check`) |
| `rb-build` | Dry-run build with package diff |
| `rb` | Build, diff, confirm, and switch generation |
| `nix-clear` | Remove old generations (keeps last 5, 7 days) |
| `nix-config` | Open this repo in Zed |

### Manual rebuild

```bash
sudo darwin-rebuild switch --flake .#moka
```

### Maintenance

```bash
nix flake update         # Update nixpkgs, nix-darwin, home-manager
nix-clear                # Garbage collect old generations
```

## Bootstrapping

```bash
# Install Nix with flakes
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# Clone the repo
git clone git@github.com:pivattogui/nixfiles.git ~/Code/nixfiles
cd ~/Code/nixfiles

# First-time switch (pick the matching host)
nix run nix-darwin -- switch --flake .#moka
```

After the first switch, use `rb` for subsequent rebuilds.

## Adding software

| Type | Where |
|------|-------|
| Nix CLI tools | `users/<login>/home.nix` → `home.packages` |
| Homebrew casks/brews | `users/<login>/default.nix` |
| New program module | New file under `pkgs/`, imported in `modules/home-common.nix` |
| System packages | `hosts/<name>/default.nix` → `environment.systemPackages` |

## Notes

- Git commits are SSH-signed via 1Password (`op-ssh-sign` configured in `pkgs/git.nix`).
- Homebrew auto-updates and cleans up on activation.
- Home Manager backs up conflicting files with the `.hm-bak` suffix.

## License

MIT
