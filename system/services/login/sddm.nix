{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    opts.greeter.sddm.enable = lib.mkEnableOption "enable sddm greeter";
  };

  config = lib.mkIf config.opts.greeter.sddm.enable {
    opts.greeter.tuigreet.enable = lib.mkForce false;

    environment.systemPackages = with pkgs; [
      rose-pine-cursor
      catppuccin-sddm
    ];

    services.displayManager.sddm = {
      enable = true;
      package = pkgs.kdePackages.sddm;
      wayland.enable = true;
      theme = "catppuccin-mocha";

      settings = {
        Theme = {
          CursorSize = 24;
          CursorTheme = "BreezeX-RosePine-Linux";
        };
      };
    };
  };
}
