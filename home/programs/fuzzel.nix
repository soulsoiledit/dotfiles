{ config, ... }:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        prompt = ''"❯ "'';
        lines = 8;
        line-height = 32;
        cache = config.xdg.stateHome + "/fuzzel";
      };
    };
  };
}
