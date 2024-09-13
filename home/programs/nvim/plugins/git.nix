{
  programs.nixvim = {
    plugins.lazygit.enable = true;

    keymaps = [
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>g";
        action.__raw = "require('lazygit').lazygit";
        options = {
          desc = "lazygit";
          silent = true;
        };
      }
    ];
  };
}
