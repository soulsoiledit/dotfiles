{ config, lib, ... }:

{
  options.modules.compositor.hyprland.enable = lib.mkEnableOption "enable hyprland compositor";
  config = lib.mkIf config.modules.compositor.hyprland.enable { programs.hyprland.enable = true; };
}
