#!/bin/sh

set -e

help() {
    cat <<EOF
Usage: $0 module
EOF
}

[ $# != 1 ] && {
    help
    exit 1
}

# $1: module_path
module_path="$1"

if echo "$module_path" | grep -E '/+$' >/dev/null;then
    echo "invalid module_path: $module_path" >&2
    exit 1
fi


prefix="$(dirname "$0")"

rm -rf build/"$module_path".build

mkdir -p build/"$module_path".build

cp -a "$module_path" build/"$module_path".build/

module="$(basename "$module_path")"

if [ -e "$module_path"/custom-main.txt ];then
    main="$(cat "$module_path"/custom-main.txt)"
elif [ -e "$module_path"/"$module" ];then
    main="$module"
elif [ -e "$module_path"/"$module".sh ];then
    main="$module".sh
fi

"$prefix"/executable-archive/make-executable-archive.sh \
         build/"$module_path".build \
         "$module"/"$main" \
         build/"$main"
