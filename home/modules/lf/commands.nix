{
  open = ''''${{
    case $(xdg-mime query filetype $f) in
    text/*) $EDITOR $fx;;
    image/svg+xml) inkscape $f &> /dev/null &;;
    image/*) imv $fx &;;
    *) for f in $fx; do xdg-open $f; done;;
    esac
  }}'';

  unarchive = ''''${{
    case "$f" in
    *.zip) unzip $f -d $(basename $f .zip);;
    *.tar.*) tar axf $f ;;
    *) echo "Unsupported format!"; read ;;
    esac
  }}'';

  trash = ''''${{
    if [ $PWD = "$HOME/.local/share/Trash/files" ]
    then
    for i in $fx;
    do trash-rm "$(basename $i)";
    done;
    else
    trash-put $fx
    fi
  }}'';

  bulk-rename = ''''${{
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
}
