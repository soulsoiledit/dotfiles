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
      incrementalSelection.enable = true;
    };

    treesitter-context = {
      enable = true;
      maxLines = 4;
    };

    treesitter-textobjects = {
      enable = true;
      lspInterop.enable = true;
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
