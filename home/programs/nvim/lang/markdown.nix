{ lib, pkgs, ... }:

{
  programs.nixvim.globals.markdown_recommended_style = false;

  programs.nixvim.autoCmd = [
    {
      event = "FileType";
      pattern = "markdown";
      callback.__raw = ''
        function(args)
          vim.lsp.start({
            name = "iwes",
            cmd = { "${lib.getExe' pkgs.iwe "iwes"}" },
            root_dir = vim.fs.root(args.buf, { ".iwe" }),
            flags = {
              debounce_text_changes = 500
            }
          })
        end
      '';
    }
  ];

  programs.nixvim.plugins = {
    lsp.servers.marksman.enable = true;

    markview = {
      enable = true;
      lazyLoad.settings = {
        lazy = false;
        # load after colorscheme
        priority = 40;
      };

      settings.markdown.list_items = {
        shift_width.__raw = ''
          function(buffer, item)
            local shiftwidth = vim.bo[buffer].shiftwidth
            local prev = math.ceil(item.indent / shiftwidth + 1)
            local final = math.ceil(item.indent / shiftwidth) * shiftwidth
            return final / prev
          end,
        '';
      };
    };

    markdown-preview = {
      enable = true;
      autoLoad = false;
    };

    lz-n.plugins = [
      {
        __unkeyed-1 = "markdown-preview.nvim";
        ft = "markdown";
      }
    ];
  };
}
