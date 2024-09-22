{
  programs.nixvim.plugins = {
    dressing.enable = true;

    noice = {
      enable = true;

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
}