#!/bin/sh

# eg.
# $ ./option-decompose.sh -o --long2 -- -oARG -abc arg1 --long arg2 --long2="ar g3"
# -o ARG -a -b -c arg1 --long 'arg2'--long2 'ar g3'
# $ ./option-decompose.sh -- --long2="ar g3"
# error: '--long2' takes no arguments.
# (to stderr, with exit status 1)
# usage
# eval set -- "$(./option-decompose.sh "$@")"

append_eof_newline() {
    cat
    echo
}

remove_eof_newline() {
    IFS= read -r line
    printf '%s' "$line"
    while IFS= read -r line;do
        printf '\n%s' "$line"
    done
}

escape() {
    # sed: "'" -> "\'"
    sed "s/'/'\\\\''/g"
}

single_quote() {
    printf "'"
    cat
    printf "'"
}

arg_opts_long=
arg_opts_short=


long_opt() {
    case "$1" in
        --*=*)
            printf '%s ' "${1%%=*}"
            printf '%s' "${1#*=}" \
                | append_eof_newline \
                | escape \
                | remove_eof_newline \
                | single_quote
            ;;
        *)
            printf '%s' "$1"
            ;;
    esac

}


short_opts() {
    (
        opt_chars=${1#?} # discard first '-'
        while [ "${#opt_chars}" -ne 0 ]; do

            tail=${opt_chars#?}
            opt_char=${opt_chars%"$tail"}

            opt_chars="$tail"
            opt="-$opt_char"

            if printf "%s\n" "$arg_opts_short" | grep -- "$opt" >/dev/null; then
                printf '%s %s ' "$opt" "$tail"
                return
            fi

            printf '%s ' "$opt"

        done

    )
}

is_after_double_dash=0
for arg in "$@";do
    if [ "$is_after_double_dash" -eq 0 ]; then

        case "$arg" in
            --) is_after_double_dash=1 ;;
                # Put \n to head of string because trailing \n is removed by shell.
            --*) arg_opts_long="$(printf "\n")$arg_opts_long $arg" ;;
            -?) arg_opts_short="$(printf "\n")$arg_opts_short $arg" ;;
            *) printf 'Invalid argument: %s\n' "$arg"; exit 1 ;;
        esac

    else

        case "$arg" in
            --*) long_opt "$arg";;
            -*) short_opts "$arg";;
            *) printf '%s' "$arg" | append_eof_newline | escape | remove_eof_newline | single_quote;;
        esac
        printf ' '
    fi
done
echo

