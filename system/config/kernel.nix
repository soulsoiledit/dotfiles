{ pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "zswap.enabled=1"
      "zswap.shrinker_enabled=1"
    ];
  };
}
