#!/bin/sh

test_error() {
    set -e
    mkdir /dev/null 2>/dev/null
    true
}

prefix="$(dirname "$0")"
. "$prefix"/../tester.sh
