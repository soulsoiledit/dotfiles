{
  programs.nixvim.plugins.which-key = {
    enable = true;
    settings.spec = [
      {
        __unkeyed-1 = "<leader>t";
        desc = "toggle terminal";
      }
      {
        __unkeyed-1 = "<leader>f";
        desc = "telescope";
      }
      {
        __unkeyed-1 = "<leader>l";
        desc = "lsp";
      }
    ];
  };
}
