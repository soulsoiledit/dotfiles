{ pkgs, ... }:

{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    catppuccin.enable = true;
    settings = {
      clock = true;
      screenshots = true;
      effect-blur = "8x2";
      indicator = true;
      ignore-empty-password = true;
    };
  };
}
