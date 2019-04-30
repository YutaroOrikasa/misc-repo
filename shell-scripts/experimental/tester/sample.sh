#!/bin/sh

# You define testcase with defining function
# which name is test*
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

# This is a wrong test definition.
# Do not put a space between function name and ().
# tester can't detect test case.
test_wrong_definition () {
    assert 1 -eq 2
}

# This is a wrong test definition.
# test function must start from line head.
    test_wrong_definition() {
    assert 1 -eq 2
}


prefix="$(dirname "$0")"

# Please load tester.sh to execute testcases.
. "$prefix"/tester.sh
