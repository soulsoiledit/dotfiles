{
  programs.nixvim = {

    opts = {
      shiftwidth = 2;
      softtabstop = 2;

      relativenumber = true;
      scrolloff = 4;

      timeoutlen = 250;
      autochdir = true;
    };

    globals = {
      localleader = "\\";
    };

    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };
  };
}
