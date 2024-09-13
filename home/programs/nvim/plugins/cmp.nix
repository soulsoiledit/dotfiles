{
  programs.nixvim.plugins = {
    luasnip.enable = true;
    friendly-snippets.enable = true;

    cmp = {
      enable = true;
      settings = {
        sources = [
          { name = "buffer"; }
          { name = "path"; }
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "calc"; }
        ];

        snippet.expand = # lua
          ''
            function(args)
              require('luasnip').lsp_expand(args.body)
            end
          '';

        mapping = {
          "<C-n>" = ''cmp.mapping.select_next_item()'';
          "<C-p>" = ''cmp.mapping.select_prev_item()'';
          "<C-f>" = ''cmp.mapping.scroll_docs(4)'';
          "<C-b>" = ''cmp.mapping.scroll_docs(-4)'';
          "<C-Space>" = ''cmp.mapping.complete()'';
          "<C-e>" = ''cmp.mapping.close()'';
          "<CR>" = ''cmp.mapping.confirm({ select = true })'';
          "<Tab>" = # lua
            ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif require("luasnip").expand_or_locally_jumpable() then
                  require("luasnip").expand_or_jump()
                else
                  fallback()
                end
              end, { "i", "s" })
            '';

          "<S-Tab>" = # lua
            ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif require("luasnip").locally_jumpable(-1) then
                  require("luasnip").jump(-1)
                else
                  fallback()
                end
              end, { "i", "s" })
            '';
        };
      };
    };
  };
}
