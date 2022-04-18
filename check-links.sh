#!/bin/bash

# check that all links land on a 200

function check_url {
  if ! curl -L --silent --fail -I $1 > /dev/null ; then
    echo "$(date +'%Y-%m-%d %H:%M:%S'): failed link: $1"
#  else
#    echo "ok: $1";
  fi
}
export -f check_url

grep "<http" living-doc-mops-streaming-opcons.md | sed -e "s/[^<]*<\([^>]*\)>[^<]*/\1/g" | xargs -n 1 -P 4 -I {} bash -c 'check_url "$@"' _ {}

