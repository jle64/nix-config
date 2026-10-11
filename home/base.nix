{ config, pkgs, ... }: {
  home = {
    username = "jonathan";
    homeDirectory = "/home/jonathan";
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;
}
