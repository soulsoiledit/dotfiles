{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      markdown-preview.enable = true;
      vimtex.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [ render-markdown ];
  };
}
