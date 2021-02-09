{ pkgs, ... }:

{
  services.dunst = {
    enable = true;

    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome3.adwaita-icon-theme;
    };

    settings = {
      global = {
        geometry = "300x0-10+30";
        separator_height = 0;
        padding = 10;
        horizontal_padding = 10;

        show_age_threshold = 60;
        idle_threshold = 120;

        font = "UbuntuMono Nerd Font 14";
        markup = "full";
        format = "<b>%s</b>\\n%b";
        word_wrap = true;
        show_indicators = false;

        icon_position = "left";
        max_icon_size = 48;

        dmenu = "${pkgs.rofi}/bin/rofi -dmenu";
        browser = "${pkgs.firefox}/bin/firefox -new-tab";
      };

      shortcuts = {
        close = "ctrl+space";
        close_all = "ctrl+shift+space";
        history = "ctrl+shift+period";
        context = "ctrl+shift+comma";
      };

      urgency_low = {
        msg_urgency = "low";
        background = "#2a2426";
        foreground = "#e6d6ac";
      };

      urgency_normal = {
        msg_urgency = "normal";
        background = "#2a2426";
        foreground = "#e6d6ac";
      };

      urgency_critical = {
        msg_urgency = "critical";
        background = "#bf616a";
        foreground = "#e68183";
      };
    };
  };
}
