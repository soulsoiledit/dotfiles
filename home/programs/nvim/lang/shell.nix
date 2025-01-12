{ pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      lsp.servers = {
        bashls.enable = true;
        fish_lsp.enable = true;
      };
    };

    extraPackages = with pkgs; [ shfmt ];
  };
}
