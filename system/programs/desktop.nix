{ pkgs, ... }:

{
  programs.niri.enable = true;
  environment.systemPackages = [ pkgs.kdePackages.polkit-kde-agent-1 ];
}
