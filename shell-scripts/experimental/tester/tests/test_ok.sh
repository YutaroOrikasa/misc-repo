#!/bin/sh

test_ok() {
    assert x = x
}

prefix="$(dirname "$0")"
. "$prefix"/../tester.sh
