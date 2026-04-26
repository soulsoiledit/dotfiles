{
  boot.kernel = {
    sysctl."vm.swappiness" = 160;
    sysfs.module.zswap.parameters = {
      enabled = 1;
      max_pool_percent = 30;
      shrinker_enabled = 1;
    };
  };
}
