{
  programs.nixvim.plugins = {
    lz-n = {
      enable = true;
      luaConfig.pre = ''
        vim.loader.enable()
      '';
    };

    lastplace.enable = true;

    snacks = {
      enable = true;
      settings = {
        bigfile.enabled = true;
        quickfile.enabled = true;
      };
    };

    mini = {
      enable = true;
      modules.basics = {
        options.extra_ui = true;
        navigation.windows = true;
      };
    };
  };
}
