{
  programs.nixvim = {
    plugins = {
      lsp.servers.marksman.enable = true;

      render-markdown.enable = true;
      markdown-preview.enable = true;
    };
  };
}
