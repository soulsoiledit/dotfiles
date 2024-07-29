{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    opts.gaming.enable = lib.mkEnableOption "enable gaming packages";
  };

  config = lib.mkIf config.opts.gaming.enable {
    programs.steam.enable = true;
    environment.systemPackages = with pkgs; [ mangohud ];
  };
}
