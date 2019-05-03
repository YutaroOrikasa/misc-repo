#!/bin/sh

# usage: . ./tester.sh

testee="$0"
export _TESTER_NOW_TESTING="$testee"

assert() {
    test "$@" || {
        printf '%-6s %s\n' Failed "$_TESTER_TESTING_FUNC"
        if [ -n "$BASH_VERSION" ];then
            _TESTER_ASSERTION_LINENO="${BASH_LINENO[0]}"
        fi
        printf '    assertion failed: %s: line %s: assert %s\n' \
               "$_TESTER_NOW_TESTING" \
               "${_TESTER_ASSERTION_LINENO:-?}" \
               "$*"

        # avoid executing _tester_onexit
        trap - EXIT

        exit 1
    }
}

# use for `'eval $assert'
assert='_TESTER_ASSERTION_LINENO=$LINENO assert'


_tester_onexit() {
    _tester_status=$?
    test x"$_tester_status" = x"0" && return

    printf '%-6s %s\n' Error "$_TESTER_TESTING_FUNC"

    # We don't have surely method to get lineno where trap occured,
    # so we print lineno as '?'.
    printf '    command error exited: %s: line ?: status %s\n' \
           "$_TESTER_NOW_TESTING" \
           "$_tester_status"
}


test_failed=0

for test_func in $(grep '^test[^ ]*()' <"$testee" \
                         | sed -e 's/()/ /g' \
                         | awk '{ print $1 }')
do
    export _TESTER_TESTING_FUNC="$test_func"
    (
        trap '_tester_onexit' EXIT
        "$test_func"
    )
    if [ $? = 0 ];then
        printf '%-6s %s\n' OK "$test_func"
    else
        test_failed=1
    fi
done

exit $test_failed
