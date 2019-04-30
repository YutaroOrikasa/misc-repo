#!/bin/sh

# eg.
# $ ./option-decompose.sh -abc arg1 --long arg2 --long2="ar g3"
# -a -b -c arg1 --long 'arg2'--long2 'ar g3'
# usage
# eval set -- "$(./option-decompose.sh "$@")"

escape() {
    
    printf "'"
    
    # sed: "'" -> "\'"
    sed "s/'/'\\\\''/g"

    printf "'"
}

long_opt() {
    if echo "$1" | grep '=' > /dev/null;then
        printf '%s ' "$(echo "$1" | head -n 1 | sed 's/=.*//')"
        printf '%s' "$1" | tr '\n' '\0' | sed 's/[^=]*=//' | escape | tr -d '\n' | tr '\0' '\n'

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


first=1
for arg in "$@";do
    if [ $first = 1 ];then
        first=0
    else
        printf ' '
    fi
    case "$arg" in
        --*) long_opt "$arg";;
        -*) short_opts "$arg";;
        *) printf '%s' "$arg" | tr '\n' '\0' | escape | tr -d '\n' | tr '\0' '\n';;
    esac
done
echo

