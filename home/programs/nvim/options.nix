{
  programs.nixvim = {
    opts = {
      expandtab = true;
      shiftwidth = 2;
      softtabstop = 2;

      relativenumber = true;
      scrolloff = 4;

      autochdir = true;
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
