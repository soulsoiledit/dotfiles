{ config, lib, ... }:

# maybe someday upstream will support this...
let
  cfg = config.modules.zswap;
in
{
  options.modules.zswap = {
    enable = lib.mkEnableOption "enable zswap";

    maxPoolPercent = lib.mkOption {
      type = lib.types.ints.between 1 100;
      apply = toString;
      default = 20;
      description = "max zswap pool size";
    };
  };

  config = lib.mkIf cfg.enable {
    # https://www.kernel.org/doc/html/latest/admin-guide/mm/zswap.html
    boot.kernelParams = [
      "zswap.enabled=1"
      "zswap.max_pool_percent=${cfg.maxPoolPercent}"
    ];
  };
}
