# NixOS & Home Manager Configuration

Configuration unifiée en mono-flake pour NixOS et Home Manager.

## Structure

```
nix-config/
├── flake.nix                       # Flake racine unique
├── flake.lock                      # Lockfile partagé
├── hosts/
│   └── sephiroth/                  # Machine NixOS sephiroth
│       ├── configuration.nix       # Configuration système
│       └── hardware-configuration.nix
└── home/                           # Configuration Home Manager
    ├── base.nix                    # Base commune utilisateur
    ├── cli.nix                     # Outils CLI & shells
    ├── desktop.nix                 # Environnement graphique & apps
    ├── gaming.nix                  # Jeux
    ├── lib/git.nix                 # Configuration Git
    └── config/                     # Dotfiles (symlinks out-of-store)
```

## Utilisation

### Sur la machine NixOS (`sephiroth`)
Home Manager est intégré directement en tant que module NixOS. Une seule commande met à jour le système et la session utilisateur :

```bash
nh os switch
```

### Sur d'autres machines (ex: `cloud` en standalone)

```bash
nh home switch --flake .#jonathan@cloud
```
ou
```bash
home-manager switch --flake .#jonathan@cloud
```
