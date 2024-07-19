{
  programs.nixvim = {
    plugins.gitsigns.enable = true;
    plugins.lazygit.enable = true;

    keymaps = [
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>g";
        lua = true;
        action = "require('lazygit').lazygit";
        options = {
          desc = "lazygit";
          silent = true;
        };
      }
    ];
  };
}
