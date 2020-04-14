#!/usr/bin/env zsh

THISFILE=${0}
THISDIR=${0:A:h}
VIZN="$(realpath $THISDIR/../vizn)" # vizn script

tmpdir=$(mktemp -d)
db="$tmpdir/test.db"

# vizn wrapper to select target db
vizn() {
  $VIZN -t $db $@
}

t_setup() {
  vizn collection create $db
  for ii in {1..10}; do
    tags="tag$(( $ii+1 )),tag$ii"
    vizn card create "echo action$ii" "$tags"
  done
}

t_teardown() {
  rm -r $tmpdir
}

t_setup
t_teardown

# Todo:
# Neue Karten werden gescheduled
# Änderung Primärkey in Cards erzeugt Update in restlicher DB
