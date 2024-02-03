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

  programs.command-not-found.enable = false;

  # zram

  environment.systemPackages = with pkgs; [
    neovim
    git
  ];
}
