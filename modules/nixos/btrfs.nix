
{
  services.btrbk.instances.home = {
    onCalendar = "hourly";

    settings = {
      timestamp_format = "long";
      snapshot_preserve_min = "1d";
      snapshot_preserve = "2w";
      volume = {
        "/" = {
          snapshot_dir = "/snapshots";
          subvolume = "home";
        };
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d /snapshots 0755 root root"
  ];
}

