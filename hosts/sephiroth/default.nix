{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/common.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/virtualisation.nix
    ../../modules/nixos/btrfs.nix
  ];

  # Host identity
  networking.hostName = "sephiroth";

  # Bootloader (Limine)
  boot.loader.limine = {
    enable = true;
    maxGenerations = 10;
    style.wallpapers = [];
    style.wallpaperStyle = "centered";
  };
  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot/efi";
  };

  # Initrd & Kernel
  boot.initrd.systemd = {
    enable = true;
    emergencyAccess = true;
  };
  boot.initrd.verbose = false;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Silent boot parameters
  boot.consoleLogLevel = 0;
  boot.kernelParams = [
    "quiet"
    "loglevel=3"
    "udev.log_level=3"
    "systemd.show_status=false"
    "rd.systemd.show_status=false"
  ];

  # Graphics & Nvidia hardware
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = true;
    nvidiaSettings = true;
  };

  # Bluetooth hardware
  hardware.bluetooth.enable = true;

  # VPN service
  services.ivpn.enable = true;
  environment.systemPackages = with pkgs; [
    ivpn
    ivpn-ui
  ];

  # Host-specific Home Manager profile for user jonathan
  home-manager.users.jonathan = {
    imports = [
      ../../home/base.nix
      ../../home/cli.nix
      ../../home/desktop.nix
      ../../home/gaming.nix
    ];
  };

  system.stateVersion = "26.05";
}
