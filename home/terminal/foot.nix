{
  programs.foot = {
    enable = true;

    settings = {
      main = {
        font = "monospace:size=10";
        selection-target = "both";
        # pad = "20x20";
      };

      mouse = {
        hide-when-typing = "yes";
      };

      scrollback.lines = 10000;

      url = {
        osc8-underline = "always";
        # label-letters = "sadfjklewcmpgh.";
      };
    };
  };

  wayland.windowManager.hyprland.settings.exec-once = [ "foot --server" ];
}
