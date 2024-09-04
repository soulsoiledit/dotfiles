{ config, lib, ... }:

{
  options.modules.zram.enable = lib.mkEnableOption "enable zram compressed swap";

  config = lib.mkIf config.modules.zram.enable {
    zramSwap = {
      enable = true;
      # fedora defaults
      memoryPercent = 100;
      memoryMax = 8589934592; # 8 GiB
    };

    # https://wiki.archlinux.org/title/Zram#Optimizing_swap_on_zram
    boot.kernel.sysctl = {
      "vm.swappiness" = 180;
      "vm.watermark_boost_factor" = 0;
      "vm.watermark_scale_factor" = 125;
      "vm.page-cluster" = 0;
    };
  };
}
