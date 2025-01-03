{
  programs.nixvim.plugins = {
    lsp.servers = {
      jsonls = {
        enable = true;
        extraOptions.init_options.provideFormatter = false;
      };

      yamlls = {
        enable = true;
        extraOptions.init_options.provideFormatter = false;
      };

      taplo.enable = true;
    };
  };
}
