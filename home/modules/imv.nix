{ pkgs, ... }:

{
  home.packages = with pkgs; [ imv ];
  # xdg.configFile."imv/config".text = ''
  #   [binds]
  #   e = prev
  #   n = next
  #   gg = goto 0
  #   <Shift+G> = goto -1
  #   m = zoom -1
  #   i = zoom 1
  #   <Shift+M> = pan 50 0
  #   <Shift+N> = pan 0 -50
  #   <Shift+E> = pan 0 50
  #   <Shift+I> = pan -50 0
  # '';
}
