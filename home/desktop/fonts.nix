{ pkgs, ... }:

let
  cjk =
    variant:
    map (x: "Noto ${variant} CJK ${x}") [
      "HK"
      "JP"
      "KR"
      "SC"
      "TC"
    ];
in
{
  home.packages = with pkgs; [
    inter
    maple-mono.NL-NF-CN-unhinted
    ibm-plex
    twitter-color-emoji
    nerd-fonts.symbols-only

    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [
        "Inter"
        "Noto Sans"
        "Symbols Nerd Font"
      ] ++ cjk "Sans";

      monospace = [
        "Maple Mono NL NF CN"
        "Noto Sans Mono"
      ] ++ cjk "Sans Mono";

      serif = [
        "IBM Plex Serif"
        "Noto Serif"
        "Symbols Nerd Font"
      ] ++ cjk "Serif";

      emoji = [
        "Twitter Color Emoji"
        "Noto Color Emoji"
      ];
    };
  };
}
