{ inputs, pkgs, ... }:

{
  programs.nixvim.plugins = {
    lsp.servers.marksman.enable = true;

    markview = {
      enable = true;
      package = pkgs.vimPlugins.markview-nvim.overrideAttrs {
        version = inputs.markview.shortRev;
        src = inputs.markview;
      };

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
