{ config, pkgs, inputs, ... }: {
  imports = [
    inputs.nix-index-database.homeModules.nix-index
  ];

  home = {
    username = "jonathan";
    homeDirectory = "/home/jonathan";
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;
}
