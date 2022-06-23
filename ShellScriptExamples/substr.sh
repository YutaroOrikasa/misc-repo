#!/bin/sh

string=1234567

repeat() {
    (
        set -ue
        char=$1
        num=$2
        if [ "$num" -lt 0 ]; then
            printf 'repeat number must be >= 0: given %s\n' "$num" >&2
            exit 1
        fi
        i=0
        while [ "$i" -ne "$num" ]; do
            printf "%s" "$char"
            : $(( i += 1 ))
        done
    )
}

# substring [$2, $3] of string $1
substr() {
    (
        str=$1
        str_len=${#str}
        k=$2
        last=${3-$k}
        if [ "$last" -lt "$k" ]; then
            echo 'MUST $2 <= $3, but' "$2 > $3" >&2
            exit 1
        fi

        if [ "$last" -gt "$str_len" ]; then # str_len is the last char index
            last=$str_len
        fi

        pattern_before=$(repeat '?' "$(( k - 1 ))")
        pattern_after=$(repeat '?' "$(( str_len - last ))")
        eval char_after_k="\${str#$pattern_before}"
        eval substr_="\${char_after_k%$pattern_after}"
        # shellcheck disable=SC2154
        printf "%s\n" "$substr_"
    )
}


substr "$string" 3
substr "$string" 2 5
substr "$string" 2 8
substr "$string" 2 10
substr "$string" 5 2
substr "$string" 0 1
