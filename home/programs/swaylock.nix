{ pkgs, ... }:

{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      clock = true;
      screenshots = true;
      effect-blur = "8x1";
      indicator = true;
      ignore-empty-password = true;
    };
  };
}