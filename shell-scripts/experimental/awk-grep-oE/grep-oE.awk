#!/usr/bin/env awk -f

BEGIN {
    if (length(pattern) == 0) {
        exit(1)
    }
}

{
    str = $0
    while (1) {
        if (match(str, pattern)) {
            print substr(str, RSTART, RLENGTH)
            str = substr(str, RSTART + RLENGTH, length(str))
        } else {
            break
        }
    }
}
