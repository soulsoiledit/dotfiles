{
  programs.nixvim.plugins = {
    nui.enable = true;
    dressing.enable = true;

    notify = {
      enable = true;
      timeout = 2500;
      render = "wrapped-compact";
      topDown = false;
    };

    noice = {
      enable = true;

      settings = {
        lsp.override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
          "cmp.entry.get_documentation" = true;
        };

        presets = {
          bottom_search = true;
        };
      };
    };
  };
}
