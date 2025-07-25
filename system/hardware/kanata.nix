{ config, lib, ... }:

let
  cfg = config.services.kanata;
in
{
  services.kanata.keyboards.default.config = # scheme
    ''
      (defsrc
        esc grv 1 2 3 4 5 6 7 8 9 0 - = bspc
        tab q w e r t y u i o p [ ] \
        caps a s d f g h j k l ; ' ret
        lsft z x c v b n m , . / rsft
        lctl lmet lalt spc ralt rctl
      )

      (defalias
        esc (tap-hold 150 150 esc lctl)
        nav (layer-while-held nav)
      )

      (deflayer base
        esc grv 1 2 3 4 5 6 7 8 9 0 - = bspc
        tab q w f p b j l u y ' [ ] \
        @esc a r s t g m n e i o ; ret
        lsft x c d v z k h , . / rsft
        lctl lmet lalt spc @nav rctl
      )

      (deflayer nav
        esc grv 1 2 3 4 5 6 7 8 9 0 - = bspc
        tab q w f p b j home up end ' [ ] \
        @esc a r s t g m left down right o ; ret
        lsft x c d v z k pgup pgdn . / rsft
        lctl lmet lalt spc _ rctl
      )
    '';

  users.users.default.extraGroups = lib.mkIf cfg.enable [ "uinput" ];
}
