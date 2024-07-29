{
  programs.nixvim.plugins = {
    luasnip.enable = true;
    friendly-snippets.enable = true;

    cmp = {
      enable = true;
      settings = {
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "path"; }
          { name = "buffer"; }
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
          "<C-b>" = ''cmp.mapping.scroll_docs(-4)'';
          "<C-f>" = ''cmp.mapping.scroll_docs(4)'';
          "<C-Space>" = ''cmp.mapping.complete()'';
          "<C-e>" = ''cmp.mapping.abort()'';
          "<CR>" = ''cmp.mapping.confirm({cmp.ConfirmBehavior.Insert, select = true })'';

          "<Tab>" = # lua
            ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.confirm({ select = true })
                elseif require("luasnip").expand_or_jumpable() then
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
                elseif require("luasnip").jumpable(-1) then
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
