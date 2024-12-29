{
  programs.nixvim.plugins = {
    lsp.servers = {
      basedpyright.enable = true;
      ruff.enable = true;
    };
  };
}
