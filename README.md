# NixOS & Home Manager Configuration

Modular configuration for NixOS and Home Manager.

## Structure

```
nix-config/
├── flake.nix                       # Root flake definition (hosts & homeConfigurations)
├── flake.lock                      # Shared lockfile
├── modules/
│   └── nixos/
│       ├── common.nix              # Base system module (CLI, users, security, networking)
│       └── desktop.nix             # Desktop stack (Niri, Noctalia, greetd, PipeWire, fonts)
├── hosts/
│   └── sephiroth/                  # Host-specific configuration
│       ├── default.nix             # Hardware, bootloader, GPU, host-specific services
│       └── hardware-configuration.nix
└── home/                           # Home Manager modules
    ├── base.nix                    # Common user configuration (username, stateVersion)
    ├── cli.nix                     # CLI tools, Neovim, shells
    ├── desktop.nix                 # Desktop apps & configs (Kitty, Niri, Noctalia)
    ├── gaming.nix                  # Gaming packages
    ├── lib/git.nix                 # Git configuration
    └── config/                     # Dotfiles (out-of-store symlinks)
```

## Adding a New Host

### Desktop or Laptop
Create `hosts/<hostname>/default.nix` importing both modules:
```nix
{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/common.nix
    ../../modules/nixos/desktop.nix
  ];

  networking.hostName = "<hostname>";
  # Add hardware, bootloader, and user home-manager imports...
}
```

### Headless Server
Create `hosts/<hostname>/default.nix` importing only `common.nix`:
```nix
{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/common.nix
  ];

  networking.hostName = "<hostname>";
  # Add server-specific settings and CLI home-manager imports...
}
```

Then register the new host in `flake.nix`:
```nix
nixosConfigurations = {
  sephiroth = mkHost ./hosts/sephiroth;
  <hostname> = mkHost ./hosts/<hostname>;
};
```

## Usage

### On NixOS hosts (`sephiroth`)
Home Manager is integrated directly as a NixOS module. A single command switches both the system and the user environment:

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
