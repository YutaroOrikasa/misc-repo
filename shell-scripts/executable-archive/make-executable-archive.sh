#!/bin/sh

help() {
    cat <<EOF
Usage: $0 dir_to_archive script output
dir_to_archive: The directory you want to archive.
script: A path of script in dir_to_archive. It will be executed after expanding archive.
output: The filename of generated archive.
EOF
}

if [ $# != 3 ];then
    help >&2
    exit 1
fi

set -e

dir_to_archive="$1"
script="$2"
output="$3"

if [ -d "$output" ];then
    echo "output $output directory exists. stopped." >&2
    exit 1
fi

rm -rf "$output"

echo '#!/bin/sh' > "$output"

chmod a+x "$output"

header_script_line_count=$(wc -l "$(dirname $0)"/header.sh | awk '{ print $1 }')

# To get line number of archive starts, we have to add `3` to $header_script_line_count
# detail of the `3`:
# #!/bin/sh line: +1
# _archive_start_line=%s; _script=%s; line: +1
# Because of archive is next to the header script: +1
archive_start_line=$(expr 3 + "$header_script_line_count")

printf '_archive_start_line=%s; _script=%s;\n' \
       "$archive_start_line" \
       "$script" \
       >> "$output"

cat "$(dirname $0)"/header.sh >> "$output"

tar -c -C "$dir_to_archive" ./ | gzip >> "$output"
