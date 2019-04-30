#!/bin/sh

test_add() {
    assert 2 -eq $(( 1 + 1 )) 
}

test_maybe_failed() {
    assert 1 -eq $(( 1 + 1 )) 
}

test_maybe_failed_print_lineno() {
    # If you want to print the line number without bash extention,
    # please use `eval $assert' instead of `assert'.
    eval $assert 1 -eq $(( 1 + 1 )) 
}


prefix="$(dirname "$0")"

"$prefix"/tester.sh "$0"
