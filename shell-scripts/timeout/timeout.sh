#!/bin/sh

# usage:
#   timeout.sh timeout_sec cmd [args...]
#
# exit status:
#   exit status of `cmd` if not timeouted
#   127 if timeouted

set -m # enable job control

# suppress job report
exec 3>&2
exec 2>/dev/null

timeout=$1
shift

observer() {
    sleep "$timeout" # Why is this sleep killed?
    kill -ALRM $$
}

trap 'kill %exec; exit 127' ALRM

observer &
exec "$@" 2>&3 &
wait %exec
status=$?

kill %observer

exit "$status"

