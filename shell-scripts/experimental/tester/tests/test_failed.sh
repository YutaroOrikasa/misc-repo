#!/bin/sh

test_failed() {
    assert x = y
}

prefix="$(dirname "$0")"
. "$prefix"/../tester.sh
