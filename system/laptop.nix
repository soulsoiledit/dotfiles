{ config, pkgs, ... }:

{
  # Laptop Power Management {{{
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  services.udev.extraRules = ''
    ACTION=="add", ATTRS{idVendor}=="c2ab", ATTRS{idProduct}=="3939", RUN+="${
      pkgs.writeShellScriptBin "kb-add" ''
        DISPLAY=:0 HOME=/home/soil ${pkgs.xorg.xinput}/bin/xinput disable 'AT Translated Set 2 keyboard'
      ''
    }/bin/kb-add"
    ACTION=="remove", ATTRS{idVendor}=="c2ab", ATTRS{idProduct}=="3939", RUN+="${
      pkgs.writeShellScriptBin "kb-remove" ''
        DISPLAY=:0 HOME=/home/soil ${pkgs.xorg.xinput}/bin/xinput enable 'AT Translated Set 2 keyboard'
      ''
    }/bin/kb-remove"
  '';
}
