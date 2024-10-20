{ config, lib, ... }:

let
  cfg = config.modules.swap;
in
{
  options.modules.swap = {
    enable = lib.mkEnableOption "enable swapfile";
    size = lib.mkOption {
      type = lib.types.ints.positive;
      description = "swap size in GiB";
    };
  };

  config = lib.mkIf cfg.enable {
    swapDevices = [
      {
        device = "/var/swapfile";
        size = cfg.size * 1024;
      }
    ];
  };
}
