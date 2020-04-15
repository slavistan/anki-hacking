#!/usr/bin/env zsh


THISFILE=${0}
THISDIR=${0:A:h}

source "$THISDIR/../src/shell.zsh"

VIZN="$(realpath $THISDIR/../vizn)" # vizn script

tmpdir=$(mktemp -d)
db="$tmpdir/test.db"

# vizn wrapper to select target db
vizn() {
  $VIZN -t $db $@
}

# sqlite3 wrappers aimed at target db and with pretty-print
sql() {
  sqlite3 $db $@
}

sqlb() {
  sql -header $@ | column -t -s '|'
}

t_setup() {
  [ ! -z "$1" ] && n="$1" || n=10
  tmpdir=$(mktemp -d)
  db="$tmpdir/test.db"
  vizn collection create $db
  for ii in {1..$n}; do
    tags="tag$(( $ii+1 )),tag$ii"
    vizn card create "echo action$ii" "$tags"
  done
}

t_teardown() {
  rm -r $tmpdir
}

t_autoschedule() {
  # Test whether new cards are automatically scheduled
  t_setup 3
  for ii in {1..3}; do
    re=$(sql "SELECT t,e FROM cards JOIN schedules USING(cardid) WHERE cards.cardid=$ii;")
    if [ ! "$re" = "0|2.5" ]; then
      errln "Test 'autoschedule' failed."
      return
    fi
  done
  logln "Test 'autoschedule' successful."
  t_teardown
}

t_autoschedule

# Todo:
# Änderung Primärkey in Cards erzeugt Update in restlicher DB
