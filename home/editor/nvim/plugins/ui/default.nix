{ pkgs, ... }:

{
  imports = [
    ./colorscheme.nix
    ./noice.nix
    ./todo.nix
    ./treesitter.nix
    ./which-key.nix
  ];

  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [ aerial-nvim ];
    plugins = {
      bufferline.enable = true;
      lualine.enable = true;

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
