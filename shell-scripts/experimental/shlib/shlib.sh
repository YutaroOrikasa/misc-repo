#!/bin/sh


shlib() {
    (
        script="$1"
        shift
        "$(dirname "$0")"/"$script" "$@"
    )
   
}
