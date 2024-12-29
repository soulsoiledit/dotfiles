{
  programs.nixvim = {
    plugins = {
      lsp.servers = {
        vtsls.enable = true;
        cssls.enable = true;
        html.enable = true;
        biome.enable = true;

      };
    };
  };
}
