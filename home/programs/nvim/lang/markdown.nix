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
          function (buffer, item)
            local parent_indent = math.max(1, item.indent - vim.bo[buffer].shiftwidth);
            return (item.indent) * (1 / (parent_indent * 2));
          end
        '';
        marker_minus.add_padding.__raw = ''
            function (_, item)
              return item.indent > 1;
          end
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
