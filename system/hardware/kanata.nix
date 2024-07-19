{
  services.kanata = {
    enable = true;
    keyboards = {
      zephyrus = {
        config = # kbd
          ''
            (defsrc
              esc grv 1 2 3 4 5 6 7 8 9 0 - = bspc
              tab q w e r t y u i o p [ ] \
              caps a s d f g h j k l ; ' ret
              lsft z x c v b n m , . / rsft
              lctl lmet lalt spc ralt rctl
              left up down right
            )

            (defalias 
              esc (tap-hold 150 150 esc lctl)
              nav (layer-while-held nav)
              oss (one-shot-press 1000 lsft)
              osc (one-shot-press 1000 lctl)
              osa (one-shot-press 1000 lalt)
              osm (one-shot-press 1000 lmet)
            )

            (deflayer base
              esc grv 1 2 3 4 5 6 7 8 9 0 - = bspc
              tab q w f p b j l u y ' [ ] \
              @esc a r s t g m n e i o ; ret
              lsft x c d v z k h , . / rsft
              lctl lmet lalt spc @nav rctl
              left up down right
            )

            (deflayer nav
              esc grv 1 2 3 4 5 6 7 8 9 0 - = bspc
              tab q w e r t y home up end p [ ] \
              @esc @osa @osm @oss @osc g h left down right ; ' ret
              lsft z x c v b pgup pgdn , . / rsft
              lctl lmet lalt spc _ rctl
              left up down right
            )
          '';

        devices = [ "/dev/input/by-id/usb-ASUSTeK_Computer_Inc._N-KEY_Device-if02-event-kbd" ];
      };
    };
  };

  users.users.user.extraGroups = [ "uinput" ];
}
