{ config, lib, pkgs, ... }:

{
  # Container virtualization
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
  
  # Virtualisation
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    dbus.enable = true;
    qemu.vhostUserPackages = [ pkgs.virtiofsd ];
  };
  users.users.jonathan.extraGroups = [ "libvirtd" ];
  environment.systemPackages = with pkgs; [
    virt-manager # contains virt-install
  ];
  
  # Cockpit
  services.cockpit = {
    enable = true;
    plugins = [
       pkgs.cockpit-files
       pkgs.cockpit-machines
       pkgs.cockpit-podman
    ];
    openFirewall = true;
    allowed-origins = [
      "https://localhost:9090"
      "https://sephiroth:9090"
      "https://*.local:9090"
    ];
  };
}
