{
  programs.nixvim.plugins = {
    lsp.servers = {
      jsonls.enable = true;
      yamlls.enable = true;
      taplo.enable = true;
    };
  };
}
