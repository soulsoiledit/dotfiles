{
  programs.nixvim = {
    plugins = {
      which-key.enable = true;
      rainbow-delimiters.enable = true;
      ccc = {
        enable = true;
        settings = {
          lsp = false;
          highlighter = {
            auto_enable = true;
            lsp = false;
          };
        };
      };

      mini.modules = {
        indentscope = { };
        trailspace = { };
        cursorword = { };
      };
    };
  };
}
