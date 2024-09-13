{ pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      mini = {
        mockDevIcons = true;
        modules.icons = { };
      };

      bufferline.enable = true;
      lualine.enable = true;
      alpha = {
        enable = true;
        theme = "dashboard";
      };

      indent-blankline.enable = true;
      # mini.modules.tabline = { };
      # mini.modules.statusline = { };
      # mini.modules.starter = { };

      which-key.enable = true;
      rainbow-delimiters.enable = true;
      nvim-colorizer.enable = true;
    };
  };
}
