# NixOS & Home Manager Configuration

Configuration for NixOS and Home Manager.

## Structure

```
nix-config/
├── flake.nix                       # Root flake definition
├── flake.lock                      # Shared lockfile
├── hosts/
│   └── sephiroth/                  # NixOS host 'sephiroth'
│       ├── configuration.nix       # System configuration
│       └── hardware-configuration.nix
└── home/                           # Home Manager configuration
    ├── base.nix                    # Common user configuration
    ├── cli.nix                     # CLI tools & shells
    ├── desktop.nix                 # Graphical environment & desktop apps
    ├── gaming.nix                  # Gaming packages
    ├── lib/git.nix                 # Git configuration
    └── config/                     # Dotfiles (out-of-store symlinks)
```

## Usage

### On NixOS hosts (e.g., `sephiroth`)

```bash
nh os switch
```

### On standalone hosts (e.g., `cloud`)

```bash
nh home switch --flake .#jonathan@cloud
```
or
```bash
home-manager switch --flake .#jonathan@cloud
```
