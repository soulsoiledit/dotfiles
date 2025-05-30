{ config, ... }:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        prompt = ''"❯ "'';

        lines = 8;
        icon-theme = config.gtk.iconTheme.name;
        horizontal-pad = 20;
        line-height = 32;

        cache = config.xdg.stateHome + "/fuzzel";
      };
    };
  };
}
