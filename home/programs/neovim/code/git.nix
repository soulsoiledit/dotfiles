{
  programs.nixvim.plugins = {
    lazygit = {
      enable = true;
      autoLoad = false;
    };

    mini.modules.diff = {
      view.style = "sign";
    };

    lz-n.plugins = [
      {
        __unkeyed-1 = "lazygit.nvim";
        cmd = "LazyGit";
        keys = [
          {
            __unkeyed-1 = "<leader>g";
            __unkeyed-2 = "<cmd>LazyGit<cr>";
            desc = "git";
          }
        ];
      }
    ];
  };
}
