{
  programs.nixvim.plugins = {
    nvim-snippets = {
      enable = true;
      settings.friendly_snippets = true;
    };
    friendly-snippets.enable = true;

    cmp = {
      settings = {
        sources = [
          {
            name = "snippets";
            priority = 10;
          }
        ];

        snippet.expand = # lua
          ''
            function(args)
              vim.snippet.expand(args.body)
            end
          '';

        mapping = {
          "<Tab>" = # lua
            ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif vim.snippet.active({direction = 1}) then
                  vim.snippet.jump(1)
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
                elseif vim.snippet.active({direction = -1}) then
                  vim.snippet.jump(-1)
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
