{
  services.mako =
    let
      background = "#1e1e2e";
      text = "#cdd6f4";
      accent = "#89b4fa";
      progress = "#313244";
    in
    {
      enable = true;
      defaultTimeout = 5000;

      width = 250;
      borderRadius = 4;

      font = "Fantasque Sans Mono 10";
      backgroundColor = "${background}";
      textColor = "${text}";
      borderColor = "${accent}";
      progressColor = "over ${progress}";

      # TODO: volume notifications
      extraConfig = ''
        [urgency=high]
        background-color=${accent}
        text-color=${background}
        border-color=${accent}

        [category=volume]
        group-by=category
        format=<b>%s</b>\n%b
      '';
    };
}
