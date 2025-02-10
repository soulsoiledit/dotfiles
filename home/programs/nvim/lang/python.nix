{
  programs.nixvim = {
    globals.python_recommended_style = false;

    plugins = {
      lsp.servers = {
        basedpyright.enable = true;
        ruff.enable = true;
      };
    };
  };
}
