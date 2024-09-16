{ pkgs, ... }:

{
  programs.nixvim.plugins = {
    bufferline.enable = true;
    lualine.enable = true;
  };
}
