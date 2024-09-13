{ pkgs, ... }:

{
  programs.nixvim = {
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

      which-key.enable = true;
      rainbow-delimiters.enable = true;
      nvim-colorizer.enable = true;
    };
  };
}
