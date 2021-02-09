{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      selection.save_to_clipbord = true;
      cursor.vi_mode_style = "Beam";
      mouse.hide_when_typing = true;

      font = {
        size = 10;
        normal.family = "UbuntuMono Nerd Font";
      };

      # miramare {{{
      colors = {
        primary = {
          background = "#2a2426";
          foreground = "#e6d6ac";
        };

        cursor = {
          text = "#2a2426";
          cursor = "#e6d6ac";
        };

        vi_mode_cursor = {
          text = "#2a2426";
          cursor = "#e6d6ac";
        };

        selection = {
          background = "#444444";
          text = "CellForeground";
        };

        search = {
          matches = {
            background = "#444444";
            foreground = "CellForeground";
          };
        };

        normal = {
          black = "#242021";
          red = "#e68183";
          green = "#87af87";
          yellow = "#d9bb80";
          blue = "#89beba";
          magenta = "#d3a0bc";
          cyan = "#87c095";
          white = "#e6d6ac";
        };

        bright = {
          black = "#444444";
          red = "#e68183";
          green = "#87af87";
          yellow = "#d9bb80";
          blue = "#89beba";
          magenta = "#d3a0bc";
          cyan = "#87c095";
          white = "#e6d6ac";
        };
      };
      # }}}

      key_bindings = [
        { key="E"; mode="Vi"; action="Up";                             }
        { key="M"; mode="Vi"; action="Left";                           }
        { key="K"; mode="Vi"; action="ScrollLineDown"; mods="Control"; }
        { key="K"; mode="Vi"; action="SemanticRightEnd";               }
        { key="K"; mode="Vi"; action="WordRightEnd"; mods="Shift";     }
        { key="I"; mode="Vi"; action="Right";                          }
        { key="L"; mode="Vi"; action="ScrollToBottom";                 }
        { key="L"; mode="Vi"; action="ToggleViMode";                   }
        { key="N"; mode="Vi"; action="Down";                           }
        { key="J"; mode="Vi"; action="SearchNext";                     }
        { key="J"; mode="Vi"; action="SearchPrevious"; mods="Shift";   }
      ];
    };
  };
}
