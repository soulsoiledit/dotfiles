{ pkgs, ... }:

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

      bs-hl-color = "f5e0dc";
      caps-lock-bs-hl-color = "f5e0dc";
      caps-lock-key-hl-color = "a6e3a1";
      inside-color = "1e1e2e";
      inside-clear-color = "1e1e2e";
      inside-caps-lock-color = "1e1e2e";
      inside-ver-color = "1e1e2e";
      inside-wrong-color = "1e1e2e";
      key-hl-color = "a6e3a1";
      layout-bg-color = "1e1e2e";
      layout-border-color = "1e1e2e";
      layout-text-color = "cdd6f4";
      line-color = "11111b";
      line-clear-color = "11111b";
      line-caps-lock-color = "11111b";
      line-ver-color = "11111b";
      line-wrong-color = "11111b";
      ring-color = "b4befe";
      ring-clear-color = "f5e0dc";
      ring-caps-lock-color = "fab387";
      ring-ver-color = "89b4fa";
      ring-wrong-color = "eba0ac";
      separator-color = "1e1e2e";
      text-color = "cdd6f4";
      text-clear-color = "f5e0dc";
      text-caps-lock-color = "fab387";
      text-ver-color = "89b4fa";
      text-wrong-color = "eba0ac";
    };
  };
}
