{ pkgs, lib, ... }:

{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      clock = true;
      screenshots = true;
      effect-blur = "8x2";
      indicator = true;
      ignore-empty-password = true;

      inside-color = lib.mkForce "1e1e2e";
      inside-clear-color = lib.mkForce "1e1e2e";
      inside-caps-lock-color = lib.mkForce "1e1e2e";
      inside-ver-color = lib.mkForce "1e1e2e";
      inside-wrong-color = lib.mkForce "1e1e2e";
      separator-color = lib.mkForce "1e1e2e";
    };
  };
}
