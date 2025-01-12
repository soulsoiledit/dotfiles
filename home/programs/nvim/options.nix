{
  programs.nixvim = {
    opts = {
      confirm = true;

      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      shiftround = true;

      relativenumber = true;
      wrap = true;

      scrolloff = 4;
      sidescrolloff = 8;

      foldmethod = "indent";
      foldlevelstart = 32;

      timeoutlen = 250;
    };

    globals = {
      mapleader = " ";
      localleader = "\\";
    };

    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };
  };
}
