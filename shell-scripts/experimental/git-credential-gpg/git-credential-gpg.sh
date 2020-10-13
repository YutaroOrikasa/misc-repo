#!/bin/sh

cred_file="$HOME/tmp.d/tmp.txt"

get_x() {
    while IFS= read -r query ;do
        set -- "$@" "$query"
    done
    < "$cred_file" grep
}


get() {
    (
        while IFS='=' read -r key value ;do
        echo "key: $key   value: $value" >&2
            case "$key" in
                protocol)   protocol="$value";;
                host)       host="$value";;
                *)          echo "unknown query $key=$value" >&2;;
            esac
        done
        < "$cred_file" grep protocol="$protocol"' ' | grep host="$host"' ' \
        | head -n 1 \
        | sed -e 's/;$//' \
        | tr ' ' '\n'
    )
}

get_() {
    (
        while IFS= read -r line ;do
        echo "$line" >&2

        done
        < "$cred_file" grep protocol="$protocol"' ' | grep host="$host"' ' \
        | head -n 1 \
        | sed -e 's/;$//' \
        | tr ' ' '\n'
    )
}

echo hello >&2
echo "args: $@" >&2
touch cred.touch
get
