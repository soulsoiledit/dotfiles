{ pkgs, ... }:

{
  home.packages = with pkgs; [
    inter

    nerd-fonts.symbols-only
    # nerd-fonts.fantasque-sans-mono
    # nerd-fonts.jetbrains-mono
    # nerd-fonts.departure-mono
    maple-mono-SC-NF
    # cascadia-code

    twitter-color-emoji

    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts =
      let
        cjk = variant: [
          "Noto ${variant} CJK JP"
          "Noto ${variant} CJK KR"
          "Noto ${variant} CJK HK"
          "Noto ${variant} CJK SC"
          "Noto ${variant} CJK TC"
        ];
      in
      {
        sansSerif = [
          "Inter"
          "Symbols Nerd Font"
          "Noto Sans"
        ] ++ cjk "Sans";

        serif = [
          "Noto Serif"
          "Symbols Nerd Font"
        ] ++ cjk "Serif";

        monospace = [
          "Maple Mono SC NF"
          "Symbols Nerd Font"
          "Noto Sans Mono"
        ] ++ cjk "Sans Mono";

        emoji = [
          "Twitter Color Emoji"
          "Noto Color Emoji"
        ];
      };
  };
}
