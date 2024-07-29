{ config, lib, ... }:

{
  options = {
    opts.compositor.hyprland.enable = lib.mkEnableOption "enable hyprland compositor";
  };

  config = lib.mkIf config.opts.compositor.hyprland.enable { programs.hyprland.enable = true; };
}
