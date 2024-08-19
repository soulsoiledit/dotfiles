{ config, lib, ... }:

{
  options.opts.zram.enable = lib.mkEnableOption "enable zram compressed swap";

  config = lib.mkIf config.opts.zram.enable {
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      memoryPercent = 150;
      writebackDevice = "/var/swapfile";
    };

    boot.kernel.sysctl = {
      "vm.swappiness" = 180;
      "vm.watermark_boost_factor" = 0;
      "vm.watermark_scale_factor" = 125;
      "vm.page-cluster" = 0;
    };
  };
}
