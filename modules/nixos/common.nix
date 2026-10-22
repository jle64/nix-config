{ config, lib, pkgs, inputs, ... }:

{
  # Nix settings and garbage collection
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Timezone and time sync
  time.timeZone = "Europe/Paris";
  services.timesyncd.enable = true;

  # Locales and console
  i18n = {
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "fr_FR.UTF-8/UTF-8"
    ];
    defaultLocale = "en_US.UTF-8";
  };
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # Users and default shells
  users.users.jonathan = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish;
  };
  users.users.root.shell = pkgs.fish;
  programs.fish.enable = true;

  # Privilege elevation (run0 with sudo shim)
  security.sudo.enable = false;
  security.run0 = {
    enable = true;
    sudo-shim.enable = true;
    wheelNeedsPassword = false;
  };
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

  # Base networking and DNS
  networking.networkmanager.enable = true;
  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    allowPing = true;
    allowedTCPPorts = [ 22 ];
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; }
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; }
    ];
  };
  services.openssh.enable = true;
  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNS = [
        "1.1.1.1"
        "9.9.9.9"
      ];
    };
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Nix helper (nh)
  programs.nh = {
    enable = true;
    flake = "/home/jonathan/Projets/nix-config";
  };

  # Essential base system packages
  environment.systemPackages = with pkgs; [
    btrfs-progs
    curl
    efibootmgr
    file
    git
    lsof
    ltrace
    nixfmt
    pciutils
    python314
    python315
    sshfs
    strace
    sysstat
    usbutils
    wget
    wireguard-tools
  ];

  # Global Home Manager configuration
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
  };
}
