{ pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernel.sysfs.module.zswap.parameters = {
      enabled = 1;
      shrinker_enabled = 1;
    };
  };
}
