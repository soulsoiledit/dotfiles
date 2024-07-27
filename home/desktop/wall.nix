{
  programs.wpaperd = {
    enable = true;
    settings.default = {
      path = "~/pictures/wallpapers/deer-sunset.jpg";
      mode = "center";
      # duration = "4h";
      # sorting = "random";
      transition.fade = { };
    };
  };
}
