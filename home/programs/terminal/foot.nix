{
  programs.foot = {
    enable = true;
    server.enable = true;

    settings = {
      main = {
        selection-target = "both";
        pad = "5x5 center";
        line-height = "14";
      };

      mouse = {
        hide-when-typing = "yes";
      };

      scrollback.lines = 10000;

      url = {
        osc8-underline = "always";
        label-letters = "arstneiowfpluyxcdhgm";
      };
    };
  };
}
