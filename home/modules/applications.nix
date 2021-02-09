{
  xdg.dataFile = {
    "applications/firefox-private.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Firefox Private Window
      GenericName=Web Browser
      Exec=firefox %U --private-window
      Icon=firefox
    '';

    "applications/multimc-nvidia.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=NVIDIA MultiMC
      GenericName=Minecraft Launcher
      Exec=nvidia-offload multimc
      Icon=multimc
    '';

    "applications/mctimer.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Speedrunning Timer
      GenericName=Timer
      Exec=mcuigt
      Icon=alarm-clock
    '';
  };
}
