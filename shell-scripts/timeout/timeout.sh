#!/bin/sh

# usage:
#   timeout.sh timeout_sec cmd [args...]
#
# exit status:
#   exit status of `cmd` if not timeouted
#   127 if timeouted

timeout=$1
shift

kill_cmd() {
    kill %'"$@"'
}

trap 'kill_cmd; exit 127' ALRM

( sleep $timeout; kill -ALRM $$) &

"$@" &
wait %'"$@"'
status=$?

kill %'( sleep $timeout'

exit $status

