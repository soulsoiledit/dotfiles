{ pkgs, ... }:

{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      grug-far-nvim
    ];

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

      # mini.modules.tabline = { };
      # mini.modules.statusline = { };
      # mini.modules.starter = { };

      which-key.enable = true;
      rainbow-delimiters.enable = true;
      nvim-colorizer.enable = true;
    };
  };
}
