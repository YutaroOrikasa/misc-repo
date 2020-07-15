#!/bin/sh

# usage:
#   timeout.sh timeout_sec cmd [args...]
#
# exit status:
#   exit status of `cmd` if not timeouted
#   127 if timeouted

timeout=$1
shift

do_cmd() {
    "$@"
}

kill_cmd() {
    kill %do_cmd
}

trap 'kill_cmd; exit 127' ALRM

( sleep $timeout; kill -ALRM $$) &

do_cmd "$@" &
wait %do_cmd
status=$?

kill %'( sleep $timeout'

exit $status

