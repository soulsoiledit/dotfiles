{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia.prime = {
    offload.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  hardware.tuxedo-keyboard.enable = true;

  boot.kernelParams=  [
    "tuxedo-keyboard.mode=0"
    "tuxedo-keyboard.brightness=0"
  ];

  environment.systemPackages = with pkgs; [
    (pkgs.writeShellScriptBin "nvidia-offload" ''
      __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia __VK_LAYER_NV_optimus=NVIDIA_only $@
    '')
  ];

  # Laptop Power Management {{{
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  services.tlp.enable = true;

  services.udev.extraRules = ''
    ACTION=="add", ATTRS{idVendor}=="c2ab", ATTRS{idProduct}=="3939", RUN+="${pkgs.writeShellScriptBin "kb-add" "DISPLAY=:0 HOME=/home/soil ${pkgs.xorg.xinput}/bin/xinput disable 'AT Translated Set 2 keyboard'
"}/bin/kb-add"
    ACTION=="remove", ATTRS{idVendor}=="c2ab", ATTRS{idProduct}=="3939", RUN+="${pkgs.writeShellScriptBin "kb-remove" "DISPLAY=:0 HOME=/home/soil ${pkgs.xorg.xinput}/bin/xinput enable 'AT Translated Set 2 keyboard'
"}/bin/kb-remove"
  '';
}
