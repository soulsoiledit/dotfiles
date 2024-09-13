{ pkgs, ... }:

{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;

      settings = {
        highlight.enable = true;
        incremental_selection.enable = true;
        indent.enable = true;
      };

      nixvimInjections = true;
    };

    treesitter-context = {
      enable = true;
      settings.max_lines = 3;
    };

    ts-autotag.enable = true;
  };

  # TODO: replace with nixvim module when added
  # https://github.com/nix-community/nixvim/issues/2103
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [ ts-comments-nvim ];
}
