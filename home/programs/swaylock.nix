{
  inputs,
  pkgs,
  ...
}:

{
  programs.swaylock = {
    enable = true;
    package = inputs.latest.legacyPackages."x86_64-linux".swaylock-effects;
    settings = {
      clock = true;
      screenshots = true;
      effect-blur = "8x1";
      indicator = true;
      ignore-empty-password = true;
    };
  };
}
