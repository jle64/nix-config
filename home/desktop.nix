{
  config,
  pkgs,
  lib,
  ...
}: let
  links = import ./lib/symlinks.nix { inherit config lib; };

  simpleFiles = {
    ".config/noctalia/settings.toml" = "noctalia/settings.toml";
  };
in {
  home = {
    packages = with pkgs; [
      brightnessctl
      kitty
      playerctl
    ];
    file = (links.linkFiles simpleFiles) // (links.linkConfigDirs [ "kitty" "mango" "niri" ]);
  };
}
