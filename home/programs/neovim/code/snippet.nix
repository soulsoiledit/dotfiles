{
  programs.nixvim.plugins = {
    luasnip.enable = true;
    friendly-snippets.enable = true;

    cmp = {
      settings = {
        sources = [
          {
            name = "luasnip";
            priority = 10;
          }
        ];

        snippet.expand = # lua
          ''
            function(args)
              require('luasnip').lsp_expand(args.body)
            end
          '';

        mapping = {
          "<CR>" = # lua
            ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  if require("luasnip").expandable() then
                    require("luasnip").expand()
                  else
                    cmp.confirm({ select = true })
                  end
                else
                  fallback()
                end
              end)
            '';

          "<Tab>" = # lua
            ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif require("luasnip").locally_jumpable(1) then
                  require("luasnip").jump(1)
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
