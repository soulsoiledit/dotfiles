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
      # gruvbox-material {{{
      colors = {
        primary = {
          background = "#1d2021";
          foreground = "#d4be98";
        };

        cursor = {
          text = "#1d2021";
          cursor = "#e6d6ac";
        };

        vi_mode_cursor = {
          cursor = "#e6d6ac";
        };

        selection = {
          background = "#3c3836";
          text = "CellForeground";
        };

        search = {
          matches = {
            background = "#a9b665";
            foreground = "#1d2021";
          };
          focused_match = {
            background = "#ea6962";
            foreground = "#1d2021";
          };
        };

        normal = {
          black = "#504945";
          red = "#ea6962";
          green = "#a9b665";
          yellow = "#d8a657";
          blue = "#7daea3";
          magenta = "#d3869b";
          cyan = "#89b482";
          white = "#d4be98";
        };

        bright = {
          black = "#504945";
          red = "#ea6962";
          green = "#a9b665";
          yellow = "#d8a657";
          blue = "#7daea3";
          magenta = "#d3869b";
          cyan = "#89b482";
          white = "#d4be98";
        };
      };
      # }}}
      key_bindings = [
        { key="M"; mode="Vi|~Search"; action="Left";                           }
        { key="M"; mode="Vi|~Search"; action="High";           mods="Shift";   }
        { key="N"; mode="Vi|~Search"; action="Down";                           }
        { key="E"; mode="Vi|~Search"; action="Up";                             }
        { key="I"; mode="Vi|~Search"; action="Right";                          }
        { key="I"; mode="Vi|~Search"; action="Low";            mods="Shift";   }
        { key="H"; mode="Vi|~Search"; action="Middle";         mods="Shift";   }
        { key="J"; mode="Vi|~Search"; action="SearchNext";                     }
        { key="J"; mode="Vi|~Search"; action="SearchPrevious"; mods="Shift";   }
        { key="K"; mode="Vi|~Search"; action="SemanticRightEnd";               }
        { key="K"; mode="Vi|~Search"; action="ScrollLineDown"; mods="Control"; }
        { key="K"; mode="Vi|~Search"; action="WordRightEnd";   mods="Shift";   }
        { key="L"; mode="Vi|~Search"; action="ScrollToBottom";                 }
        { key="L"; mode="Vi|~Search"; action="ToggleViMode";                   }
      ];
    };
  };
}
