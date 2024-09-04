{ pkgs, ... }:

{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [ aerial-nvim ];
    plugins = {
      # bufferline.enable = true;
      # lualine.enable = true;
      mini.modules.tabline = { };
      mini.modules.statusline = { };

      alpha = {
        enable = true;
        theme = "theta";
      };

      indent-blankline.enable = true;
      rainbow-delimiters.enable = true;
      nvim-colorizer.enable = true;

      yanky = {
        enable = true;
        settings.highlight.timer = 125;
      };
    };
  };
}
