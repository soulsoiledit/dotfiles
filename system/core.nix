{ pkgs, inputs, ... }:

{
  system.stateVersion = "23.11";

  time.timeZone = "US/Central";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        editor = false;
        configurationLimit = 16;
      };

      timeout = 0;
    };

    plymouth = {
      enable = true;
    };
  };

  # zram
  zramSwap = {
    enable = true;
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 180;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;
  };

  # btrfs options
  fileSystems."/".options = [
    "compress=zstd"
    "noatime"
    "autodefrag"
  ];

  environment.systemPackages = with pkgs; [
    neovim
    git
  ];
}
