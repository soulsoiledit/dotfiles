{ pkgs, ... }:
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

      timeout = 2;
    };

    plymouth = {
      enable = true;
    };
  };

  # programs.command-not-found.enable = false;

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

  environment.systemPackages = with pkgs; [
    neovim
    git
  ];

  # catppuccin colors
  console.colors = [
    "1e1e2e"
    "f38ba8"
    "a6e3a1"
    "f9e2af"
    "89b4fa"
    "f5c2e7"
    "94e2d5"
    "bac2de"
    "585b70"
    "f38ba8"
    "a6e3a1"
    "f9e2af"
    "89b4fa"
    "f5c2e7"
    "94e2d5"
    "a6adc8"
  ];
}
