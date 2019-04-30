#!/bin/sh

# stop if tester is executed recursively
if [ x"$1" = x"$_TESTER_NOW_TESTING" ];then
    exit
fi

testee="$1"
export _TESTER_NOW_TESTING="$testee"

source "$testee"

assert() {
    test "$@" || {
        printf '%-6s %s\n' Faild "$_TESTER_TESTING_FUNC"
        if [ -n "$BASH_VERSION" ];then
            _TESTER_ASSERTION_LINENO="${BASH_LINENO[0]}"
        fi
        printf '    assertion faild: %s: line %s: assert %s\n' \
               "$_TESTER_NOW_TESTING" \
               "${_TESTER_ASSERTION_LINENO:-?}" \
               "$*"
        exit 1
    }
}

# use for `'eval $assert'
assert='_TESTER_ASSERTION_LINENO=$LINENO assert'

test_failed=0

for test_func in $(grep '^test[^ ]*()' <"$testee" \
                         | sed -e 's/()/ /g' \
                         | awk '{ print $1 }')
do
    export _TESTER_TESTING_FUNC="$test_func"
    ("$test_func")
    if [ $? = 0 ];then
        printf '%-6s %s\n' OK "$test_func"
    else
        test_failed=1
    fi
done

exit $test_failed
