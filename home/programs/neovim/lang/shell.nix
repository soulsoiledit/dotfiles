{ pkgs, ... }:

{
  programs.nixvim = {
    extraPackages = with pkgs; [ shfmt ];

    plugins = {
      lsp.servers = {
        bashls.enable = true;
        fish_lsp.enable = true;
      };
    };
  };
}
