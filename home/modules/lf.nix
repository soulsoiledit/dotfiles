{ config, pkgs, ... }:

{
  programs.lf = {
    enable = true;

    settings = {
      number = true;
      relativenumber = true;
      icons = true;
      timefmt = "Mon 2006-01-02 15:04";
      period = 1;
      ifs = "\\n";
    };

    keybindings = {
      m = "updir";
      n = "down";
      e = "up";
      i = "open";

      h = "mark-save";
      j = "search-next";
      J = "search-prev";
      k = "$$EDITOR $fx";
      l = "$$PAGER $fx";

      "." = "set hidden!";
      a = "&for i in $fx; do arc unarchive $i; done";
      R = "bulk-rename $fx";
      DD = ":trash";
      DU = "$trash-restore";

      td = "push $mkdir<space>";
      tf = "push $touch<space>";
      te = "$chmod +x $fx";
      tn = "$chmod -x $fx";

      gn = "cd /etc/nixos";
      gp = "cd ~/pictures";
      gm = "cd ~/.local/share/polymc/instances/Main/.minecraft/";
      gt = "cd ~/.local/share/Trash/files";
      gu = "cd /run/media/${config.home.username}/";

      gc = "cd ~/.config/nvim";
      gl = "cd ~/.local/share/nvim/site/pack/";
    };

    commands = {
      open = ''
        ''${{
                case $(xdg-mime query filetype $f) in
                    text/*) $EDITOR $fx;;
                    image/svg+xml) inkscape $f &> /dev/null &;;
                    image/*) imv $fx &;;
                *) for f in $fx; do xdg-open $f; done;;
                esac
              }}'';

      trash = ''
        %{{
                if [ $PWD = "$HOME/.local/share/Trash/files" ]
                then
                    for i in $fx;
                        do trash-rm "$(basename $i)";
                    done;
                else
                    trash-put $fx
                fi
              }}'';

      bulk-rename = ''
        ''${{
                old=$(mktemp)
                new=$(mktemp)
                [ -n $fs ] && fs=$(ls)
                printf "$fs\n" > $old
                printf "$fs\n" > $new
                $EDITOR $new
                [ $(cat $new | wc -l) -ne $(cat $old | wc -l) ] && exit
                paste $old $new | while read names; do
                src=$(printf $names | cut -f1)
                dst=$(printf $names | cut -f2)
                [ $src = $dst ] && continue
                [ -e $dst ] && continue
                mv $src $dst
                done
                rm $old $new
                lf -remote "send $id unselect"
              }}'';
    };
  };

  home = {
    sessionVariables = {
      LF_ICONS = ''
        tw=:st=:ow=:dt=:di=:\
        fi=:ln=:or=:ex=:\
        *.c=:*.cc=:*.cpp=:\
        *.h=:*.hh=:*.hpp=:\
        *.coffee=:*.js=:*.ts=:\
        *.html=:*.css=:\
        *.java=:*.scala=:*.jar=:\
        *.clj=:*.exs=:*.json=:*.md=:*.php=:*.pl=:\
        *.py=:*.rb=:*.lua=:\
        *.vim=:*.hs=:*.rs=:*.go=:*.nix=:\
        *.sh=:*.bash=:*.zsh=:*.fish=:\
        *.tar=:*.gz=:*.xz=:*.zst=:*.bz2=:*.bz=:\
        *.zip=:*.rar=:*.7z=:\
        *.jpg=:*.jpeg=:*.png=:*.svg=:*.gif=:\
        *.mov=:*.webm=:*.mp4=:\
        *.mp3=:*.ogg=:*.wav=:\
        *.pdf=:\
      '';
    };

    packages = with pkgs; [ archiver ];
  };
}
