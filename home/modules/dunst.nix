{ pkgs, ... }:

{
  services.dunst = {
    enable = true;

    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
    };

    settings =
      let theme = (import ../../other/colors.nix).theme;
      in {
        global = {
          geometry = "300x0-10+30";
          padding = 10;
          horizontal_padding = 10;

          show_age_threshold = 60;
          idle_threshold = 120;

          font = "FantasqueSansMono Nerd Font 14";
          markup = "full";
          format = "<b>%s</b>\\n%b";
          word_wrap = true;

          icon_position = "left";
          max_icon_size = 48;

          dmenu = "${pkgs.rofi}/bin/rofi -dmenu";
          browser = "${pkgs.firefox}/bin/firefox -new-tab";

          frame_width = 0;
          separator_height = 10;
          separator_color = "#00000000";
        };

        shortcuts = {
          close = "ctrl+space";
          close_all = "ctrl+shift+space";
          history = "ctrl+shift+period";
          context = "ctrl+shift+comma";
        };

        urgency_low = {
          msg_urgency = "low";
          background = theme.background;
          foreground = theme.foreground;
        };

        urgency_normal = {
          msg_urgency = "normal";
          background = theme.background;
          foreground = theme.foreground;
        };

        urgency_critical = {
          msg_urgency = "critical";
          background = theme.highlight;
          foreground = theme.background;
        };
      };
  };
}
