#!/bin/sh

prefix="$(dirname "$0")"

test_decompose_short_options() {
    eval set -- "$("$prefix"/option-decompose.sh -abc)"

    assert x"$1" = x"-a"
    assert x"$2" = x"-b"
    assert x"$3" = x"-c"

}

test_decompose_short_options_and_an_argument() {
    eval set -- "$("$prefix"/option-decompose.sh -abc arg)"

    assert x"$1" = x"-a"
    assert x"$2" = x"-b"
    assert x"$3" = x"-c"
    assert x"$4" = x"arg"

}

test_decompose_long_option() {
    eval set -- "$("$prefix"/option-decompose.sh --long-opt)"

    assert x"$1" = x"--long-opt"

}

test_decompose_long_option_eq_argument() {
    eval set -- $("$prefix"/option-decompose.sh --long-opt=arg)

    assert x"$1" = x"--long-opt"
    assert x"$2" = x"arg"

}

test_decompose_long_option_eq_argument_containing_eq() {
    eval set -- $("$prefix"/option-decompose.sh --long-opt=flag=on)

    assert x"$1" = x"--long-opt"
    assert x"$2" = x"flag=on"

}

test_decompose_long_option_eq_argument_containing_single_quote() {
    eval set -- $("$prefix"/option-decompose.sh --long-opt="arg'n")

    assert x"$1" = x"--long-opt"
    assert x"$2" = x"arg'n"

}

test_decompose_long_option_eq_argument_containing_double_quote() {
    eval set -- $("$prefix"/option-decompose.sh --long-opt=\")

    assert x"$1" = x"--long-opt"
    assert x"$2" = x\"

}

test_decompose_long_option_eq_newline_argument_containing_eq() {
    eval set -- "$("$prefix"/option-decompose.sh --long-opt='fl
ag=on')"

    assert x"$1" = x"--long-opt"
    assert x"$2" = x"fl
ag=on"

}

test_argument_includes_space() {
    eval set -- $("$prefix"/option-decompose.sh "hello world")
    assert x"$1" = x"hello world"
}

test_raw_argument_includes_newline() {
    arg="$("$prefix"/option-decompose.sh "hello
world")"
    assert x"$arg" = x"'hello
world'"
}

test_argument_includes_newline() {
    eval set -- "$("$prefix"/option-decompose.sh "hello
world" "_")"
    assert x"$1" = x"hello
world"
    assert x"$2" = x"_"
}

test_setopt_includes_newline() {
    eval set -- "'a
b'"
    assert x"$1" = x'a
b'
}

test_argument_containing_escape() {
    eval set -- "$("$prefix"/option-decompose.sh "\"hello world\"")"
    assert x"$1" = x"\"hello world\""
}

test_argument_not_expanded() {
    eval set -- "$("$prefix"/option-decompose.sh '$0')"
    assert x"$1" = x'$0'
}

. "$prefix"/../tester/tester.sh
