
# _archive_start_line=?; _script=?; are above.

tmpdir=$(mktemp -d)

trap "rm -rf $tmpdir" EXIT

tail -n +$_archive_start_line < $0 | gunzip | tar -x -C $tmpdir

$tmpdir/"$_script" "$@"
exit

# tar.gz archive is below
