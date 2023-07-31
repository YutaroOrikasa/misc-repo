#!/bin/sh

# eg.
# $ ./option-decompose.sh -abc arg1 --long arg2 --long2="ar g3"
# -a -b -c arg1 --long 'arg2'--long2 'ar g3'
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

long_opt() {
    if printf '%s' "$1" | grep '=' > /dev/null;then
        printf '%s ' "${1%%=*}"
        printf '%s' "${1#*=}" \
            | append_eof_newline \
            | escape \
            | remove_eof_newline \
            | single_quote
    else
        printf '%s' "$1"
    fi

    
}


short_opts() {
    echo "$1" | fold -w1 | \
        {
            IFS= read -r  # discard first '-'
            while IFS= read -r char;do
                printf '%s ' -"$char"
            done
        }
}


for arg in "$@";do
    case "$arg" in
        --*) long_opt "$arg";;
        -*) short_opts "$arg";;
        *) printf '%s' "$arg" | append_eof_newline | escape | remove_eof_newline | single_quote;;
    esac
    printf ' '
done
echo

