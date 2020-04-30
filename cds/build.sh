#!/usr/bin/env sh

case $1 in
  watchnreload)
    trap exit INT QUIT
    trap "rm -rf $tmpdir" EXIT

    echo -n "Select browser window to reload ... "
    wid=$(xdotool selectwindow)
    echo $wid

    tmpdir=$(mktemp -d)
    fifo=$tmpdir/fifo
    mkfifo $fifo

    find '.' -type f -not -path '*/\.*' -not -name 'sqlite.db' -not -path './node_modules/*' |
      entr -r $0 reload $wid $fifo
    ;;
  reload)
    shift
    cds watch | tee $2 &
    ( cat $2 & ) | grep -qF '[ terminate with ^C ]'
    xdotool key --window $1 F5
    ;;
esac
