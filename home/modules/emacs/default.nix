{ pkgs, ... }:

{
  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom;

    extraPackages = with pkgs; [
      ripgrep fd
    ];
  };

  services.emacs = {
    enable = true;
    client.enable = true;
  };
}
