{ pkgs, ... }:

{
  programs.nixvim = {
    plugins.markdown-preview.enable = true;

    extraPlugins = with pkgs.vimPlugins; [
      render-markdown
    ];
  };
}
