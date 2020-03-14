#!/usr/bin/env zsh

THISFILE=${0:A}
THISDIR=${0:A:h}

main() {
  echo "main .."
  INFILE=$THISDIR/anki-hacking.md

  # Produce output html

  HTML=$(mktemp --suffix='.html')

  # Run surf and retrieve its window id

  min "file://$HTML" &
  PID=$(echo $!)
  echo $PID
  while [ -z $WINIDS ]; do # wait for windows to spawn
    sleep 0.3
    WINIDS=$(xdotool search --pid $PID) # returns multiple ids :/
  done

  cmd="$THISFILE reload $INFILE $HTML $(echo -n $WINIDS | tr '\n' ':')"
  echo "[MAIN] Entering loop ..."
  echo "[MAIN] INFILE = '$INFILE'"
  echo "[MAIN] HTML = '$HTML'"
  echo $INFILE | entr -ps "$cmd"
}

reload() {
  echo "[RELOAD] Converting ..."
  echo "[RELOAD] INFILE = '$1'"
  echo "[RELOAD] OUTFILE = '$2'"
  pandoc -s -f markdown -t html5 $1 > $2
  echo "[RELOAD] Sending keys ..."
  for winid in $(echo $3 | tr ':' '\n'); do
    echo "[RELOAD] Sending key to window $winid"
    xdotool key --window $winid 'ctrl+r' # reload does not work.
  done
}

if [ "$#" = "0" ]; then
  main
else
  $@
fi
