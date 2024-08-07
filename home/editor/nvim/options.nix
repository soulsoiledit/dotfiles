{
  programs.nixvim = {

    opts = {
      expandtab = true;
      shiftwidth = 2;
      softtabstop = 2;

      relativenumber = true;
      scrolloff = 4;

      timeoutlen = 250;
      autochdir = true;
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
