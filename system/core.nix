{ pkgs, ... }:

{
  system.stateVersion = "23.11";

  # set timezone (automatically)
  time.timeZone = "US/Central";

  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_stable;
    kernelParams = [ "quiet" ];

    crashDump.enable = true;

    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        editor = false;
        configurationLimit = 16;
      };

      # grub = {
      #   enable = true;
      #   backgroundColor = "#1e1e2e";
      #   configurationLimit = 16;
      #   default = "saved";
      #   device = "/dev/disk/by-label/boot";
      #   efiSupport = true;
      #   useOSProber = true;
      # };

      timeout = 0;
    };

    plymouth = {
      enable = true;
    };
  };

  # zram
  zramSwap = {
    # enable = true;
  };

  boot.kernel.sysctl = {
    # "vm.swappiness" = 180;
    # "vm.watermark_boost_factor" = 0;
    # "vm.watermark_scale_factor" = 125;
    # "vm.page-cluster" = 0;
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
  ];
}
