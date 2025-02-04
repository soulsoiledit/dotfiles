{ pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      lsp.servers.tinymist = {
        enable = true;
        extraOptions.single_file_support = true;
        settings = {
          exportPdf = "onSave";
          formatterMode = "typstyle";
        };
      };

      lz-n.plugins = [
        {
          __unkeyed-1 = "typst-preview.nvim";
          ft = "typst";
          after.__raw = ''
            function()
              require("typst-preview").setup({
                invert_colors = '{"rest": "auto", "image": "never"}',
              })
            end
          '';
        }
      ];
    };

    extraPlugins = [
      {
        plugin = pkgs.vimPlugins.typst-preview-nvim;
        optional = true;
      }
    ];

    extraPackages = [ pkgs.typstyle ];
  };
}
