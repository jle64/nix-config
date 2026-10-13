{
  services.snapper = {
    snapshotInterval = "hourly";
    persistentTimer = true;
    cleanupInterval = "1d";

    configs.home = {
      SUBVOLUME = "/home";
      FSTYPE = "btrfs";

      TIMELINE_CREATE = true;
      TIMELINE_CLEANUP = true;

      TIMELINE_LIMIT_HOURLY = 24;
      TIMELINE_LIMIT_DAILY = 7;
      TIMELINE_LIMIT_WEEKLY = 4;
      TIMELINE_LIMIT_MONTHLY = 3;
    };
  };
}
