{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

{
  imports = [ inputs.niri.nixosModules.niri ];

  options.modules.compositor.niri.enable = lib.mkEnableOption "enable niri compositor";

  config = lib.mkIf config.modules.compositor.niri.enable {
    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };
  };
}
