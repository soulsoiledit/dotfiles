{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;

      settings.highlight.enable = true;
      nixvimInjections = true;
    };

    # treesitter-context = {
    #   enable = true;
    #   settings.max_lines = 3;
    # };
    #
    # ts-autotag.enable = true;
    # ts-comments.enable = true;
  };
}
