{ config, lib, pkgs, ... }:

{
  # Virtual terminal (kmscon)
  services.kmscon = {
    enable = true;
    config.hwaccel = true;
  };

  # Display manager and greeter
  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings = {
      default_session = {
        user = "greeter";
        command = "${pkgs.tuigreet}/bin/tuigreet --cmd ${config.programs.niri.package}/bin/niri-session";
      };
    };
  };

  # Wayland compositor (Niri) and Noctalia desktop
  systemd.user.services.niri.enableDefaultPath = false;
  programs.niri.enable = true;
  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;
  };

  # Audio (PipeWire)
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  # Desktop fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    dejavu_fonts
  ];

  # Desktop services and integrations
  services.flatpak.enable = true;
  services.printing = {
    enable = true;
    browsing = true;
    browsedConf = ''
      BrowseDNSSDSubTypes _cups,_print
    '';
  };
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.oo7.enable = true;
  services.gnome.gnome-keyring.enable = false;
  security.pam.services.greetd.oo7.enable = true;
  programs.gnupg.agent.enable = true;

  # AppImage binary format support
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # Desktop user groups
  users.users.jonathan.extraGroups = [ "video" "audio" ];

  # Desktop-specific system packages
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    android-tools
    atop
    bazaar
    bpftrace
    cliphist
    ddcutil
    file-roller
    glib # for gdbus
    gnome-text-editor
    gnupg
    gpu-screen-recorder
    kdePackages.kdeconnect-kde
    mpv
    nautilus
    scrcpy
    sunshine
    tuigreet
    warehouse
    waypipe
    wireplumber
    xwayland-satellite
  ];
}
