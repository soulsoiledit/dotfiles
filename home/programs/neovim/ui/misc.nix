{
  programs.nixvim = {
    plugins = {
      which-key.enable = true;
      rainbow-delimiters.enable = true;
      ccc = {
        enable = true;
        settings = {
          lsp = false;
          highlighter.auto_enable = true;
        };
      };

      snacks.settings.indent = {
        indent.only_scope = true;
      };

      mini.modules.cursorword = { };
    };
  };
}
