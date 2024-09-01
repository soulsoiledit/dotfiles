{ config, inputs, lib, pkgs, ... }:

{
  imports = [ inputs.niri.nixosModules.niri ];

  options = {
    opts.compositor.niri.enable = lib.mkEnableOption "enable niri compositor";
  };

  config = lib.mkIf config.opts.compositor.niri.enable {
    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };
  };
}
