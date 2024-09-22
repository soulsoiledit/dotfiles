{ pkgs, ... }:

{
  programs.nixvim.plugins = {
    bufferline.enable = true;
    lualine.enable = true;
  };

  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    dropbar-nvim
  ];
}
