#!/bin/sh

prefix="$(dirname "$0")"


test_ok() {
    "$prefix"/test_ok.sh | {
        read -r _1 _2
        assert x"$_1" = x"OK"
        assert x"$_2" = x"test_ok"
    }
    
}

test_failed() {
    "$prefix"/test_failed.sh | {
        # line 1
        read -r _1 _2
        assert x"$_1" = x"Failed"
        assert x"$_2" = x"test_failed"

        # line2
        read -r _1 _2 _
        assert x"$_1 $_2" = x"assertion failed:"
    }
}

test_error() {
    "$prefix"/test_error.sh | {
        # line 1
        read -r _1 _2
        assert x"$_1" = x"Error"
        assert x"$_2" = x"test_error"

        # line2
        read -r _1 _2 _3 _
        assert x"$_1 $_2 $_3" = x"command error exited:"
    }
}

. "$prefix"/../tester.sh
