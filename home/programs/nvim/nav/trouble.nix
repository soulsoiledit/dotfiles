{
  programs.nixvim = {
    plugins.trouble.enable = true;

    keymaps = [
      {
        mode = "n";
        key = "<leader>d";
        action = "<cmd>Trouble diagnostics toggle<CR>";
        options.desc = "diagnostics";
      }

      {
        mode = "n";
        key = "<leader>q";
        action = "<cmd>Trouble qflist toggle<CR>";
        options.desc = "quickfix";
      }
    ];
  };
}
