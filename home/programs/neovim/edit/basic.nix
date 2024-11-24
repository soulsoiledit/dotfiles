{
  programs.nixvim.plugins = {
    lastplace.enable = true;
    lazy.enable = true;
    snacks = {
      enable = true;
      settings.bigfile.enable = true;
    };

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
