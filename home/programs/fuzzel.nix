{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        prompt = "\"❯ \"";
        icon-theme = "Papirus-Dark";
        terminal = "foot -e";

        width = 30;
        horizontal-pad = 20;
        lines = 8;
        line-height = 25;
      };

      border = {
        width = 1;
        radius = 15;
      };
    };
  };
}
