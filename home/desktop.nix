{
  config,
  pkgs,
  lib,
  ...
}: let
  dotfilesDir = "${config.home.homeDirectory}/Projets/nix-config/home/config";

  simpleFiles = {
    ".config/noctalia/settings.toml" = "noctalia/settings.toml";
  };

  fileAttrs =
    lib.mapAttrs (target: src: {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/${src}";
    }) simpleFiles;

  configDirs = [
    "kitty"
    "mango"
    "niri"
  ];

  dirAttrs =
    lib.genAttrs
    (map (n: ".config/${n}") configDirs)
    (path: {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/${builtins.baseNameOf path}";
    });
in {
  home = {
    packages = with pkgs; [
      brightnessctl
      kitty
      playerctl
    ];
    file = fileAttrs // dirAttrs;
  };
}
