#!/usr/bin/env

tagecho() {
  TAG="$1"
  shift
  echo "$@" | sed 's/^/['"$TAG"'] /g'
}

errln() {
  echo "\033[31;1m[ERR ]\033[0m $@"
}

logln() {
  echo "\033[32;1m[INFO]\033[0m $@"
}

hlline() {
  [ "$#" -eq 0 ] && n=1 || n="$1"
  cat "-" | sed "$n,$n"' s/^\(.*\)$/'$(printf "\033[32;1m")'\1'$(printf "\033[0m")'/g'
}

# Macro to call funcname__usage if '-h', '--help' or '-?' is passed as parameter
# Usage: 'eval $HELPMACRO'
HELPMACRO='if [ "$1" = "-h" ] || [ "$1" = "--help" ] || [ "$1" = "-?" ]; then
"$funcstack[2]__usage"
exit
fi'

