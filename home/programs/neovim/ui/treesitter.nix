{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;

      settings.highlight.enable = true;
      nixvimInjections = true;
    };

    # ts-autotag.enable = true;
    # ts-comments.enable = true;
  };
}
