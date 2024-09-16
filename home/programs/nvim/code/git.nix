{
  programs.nixvim = {
    plugins = {
      lazygit.enable = true;
      mini.modules.diff = {
        view.style = "sign";
      };
    };

    keymaps = [
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>g";
        action.__raw = "require('lazygit').lazygit";
        options.desc = "git";
      }
    ];
  };
}
