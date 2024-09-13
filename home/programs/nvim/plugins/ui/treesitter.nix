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
    ts-context-commentstring = {
      enable = true;
      languages = {
        yuck = ";; %s";
      };
    };
  };
}
