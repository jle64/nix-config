{ config, lib }:

let
  dotfilesDir = "${config.home.homeDirectory}/Projets/nix-config/home/config";
in
{
  inherit dotfilesDir;

  # Create an out-of-store symlink to a single file or directory inside dotfilesDir
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/${path}";

  # Map an attribute set of { targetPath = sourcePath; } to out-of-store symlink definitions
  linkFiles =
    files:
    lib.mapAttrs (_target: src: {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/${src}";
    }) files;

  # Map a list of directory names ["dir1" "dir2"] to ".config/<name>" symlink definitions
  linkConfigDirs =
    dirs:
    lib.genAttrs (map (n: ".config/${n}") dirs) (path: {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/${builtins.baseNameOf path}";
    });
}
