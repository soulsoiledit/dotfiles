{
  programs.nixvim.plugins = {
    lastplace.enable = true;
    hardtime.enable = true;

    mini = {
      enable = true;

      modules = {
        basics = {
          options.extra_ui = true;
          navigation.windows = true;
        };
      };
    };
  };
}
