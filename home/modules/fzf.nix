{ pkgs, ... }:

{
  home.packages = with pkgs; [ perl ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
