# NixOS & Home Manager Configuration

Configuration for NixOS and Home Manager.

## Structure

```
nix-config/
├── flake.nix                       # Root flake
├── modules/
│   └── nixos/
│       ├── common.nix              # Common stuff
│       └── desktop.nix             # Desktop stack
├── hosts/
│   └── HOSTNAME/                   # Host-specific configuration
│       ├── default.nix
│       └── hardware-configuration.nix
└── home/                           # Home Manager modules
    ├── base.nix                    # Base configuration (username, stateVersion)
    ├── cli.nix                     # CLI tools
    ├── desktop.nix                 # Desktop apps
    ├── gaming.nix                  # Gaming apps
    ├── lib/git.nix                 # Git config
    └── config/                     # Dotfiles (out-of-store symlinks)
```

## Usage

### On NixOS
Home Manager is integrated directly as a NixOS module. A single command switches both the system and the user environment:

```bash
nh os switch
```

### With home-manager

```bash
nh home switch --flake .#jonathan@cloud
```
or
```bash
home-manager switch --flake .#jonathan@cloud
```
