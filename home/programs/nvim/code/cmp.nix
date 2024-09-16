{
  programs.nixvim.plugins = {
    lspkind.enable = true;

    cmp = {
      enable = true;
      settings = {
        sources = [
          {
            name = "nvim_lsp";
            priority = 10;
          }
          { name = "latex_symbols"; }

          {
            name = "buffer";
            priority = 10;
          }
          { name = "path"; }
          { name = "calc"; }
          { name = "spell"; }
        ];

        mapping = {
          "<C-f>" = ''cmp.mapping.scroll_docs(4)'';
          "<C-b>" = ''cmp.mapping.scroll_docs(-4)'';
          "<C-n>" = ''cmp.mapping.select_next_item()'';
          "<C-p>" = ''cmp.mapping.select_prev_item()'';
          "<C-e>" = ''cmp.mapping.close()'';
        };
      };
    };
  };
}
