#!/usr/bin/env zsh

THISFILE=${0}
THISDIR=${0:A:h}

source "$THISDIR/../src/shell.zsh" # utilities

VIZN="$(realpath $THISDIR/../vizn)" # vizn script

tmpdir=$(mktemp -d)
db="$tmpdir/test.db"

# vizn wrapper to select target db
vizn() {
  $VIZN -t $db $@
}

# sqlite3 wrappers aimed at target db and with pretty-print
sql() {
  sqlite3 -cmd "PRAGMA foreign_keys=ON;" $db $@
}

sqlb() {
  sql -header $@ | column -t -s '|'
}

t_setup() {
  [ ! -z "$1" ] && n="$1" || n=10
  tgt=/dev/null
  tmpdir=$(mktemp -d)
  db="$tmpdir/test.db"
  vizn collection create $db > $tgt
  for ii in {1..$n}; do
    tags="tag$(( $ii+1 )),tag$ii"
    vizn card create "echo action$ii" "$tags" > $tgt
  done
}

t_teardown() {
  rm -r $tmpdir
}

t_autoschedule() {
  # Test whether new cards are automatically scheduled
  ok=1
  t_setup 3
  for ii in {1..3}; do
    re=$(sql "SELECT t,e FROM cards JOIN schedules USING(cardid) WHERE cards.cardid=$ii;")
    if [ ! "$re" = "0|2.5" ]; then
      ok=0
    fi
  done
  [ "$ok" -eq 1 ] && logln "Test 'autoschedule' successful." || errln "Test 'autoschedule' failed."
  t_teardown
}

t_fkeycascade(){
  # Test cascading of foreign-key update/delete.
  ok=1
  t_setup 3
  sql "DELETE FROM cards WHERE cardid=1;" "UPDATE cards SET cardid=1337 WHERE cardid=3;"
  if [ ! -z $(comm -23 <(sql "select cardid from cards;" | sort) <(echo "1337\n2")) ] ||
    [ ! -z $(comm -23 <(sql "select cardid from cards;" | sort) <(echo "1337\n2")) ]; then
    ok=0
  fi
  [ "$ok" -eq 1 ] && logln "Test 'fkeycascade' successful." || errln "Test 'fkeycascade' failed."
  t_teardown
}

t_autoschedule
t_fkeycascade
