{
  programs.nixvim.plugins.which-key = {
    enable = true;
    registrations = {
      "<leader>t" = "toggle terminal";
      "<leader>f".name = "telescope";
      "<leader>l".name = "lsp";
    };
  };
}
