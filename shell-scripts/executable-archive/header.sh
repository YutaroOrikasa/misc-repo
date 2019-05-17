
# _archive_start_line=?; _script=?; are above.

tmpdir=$(mktemp -d)

trap "rm -rf $tmpdir" EXIT

# if $0 is an ablosute path or a relative path,
# $self = $0
# if $0 is a command in $PATH,
# $self is absolute path of $0
self="$(command -v "$0")"

tail -n +$_archive_start_line < "$self" | gunzip | tar -x -C $tmpdir

$tmpdir/"$_script" "$@"
exit

# tar.gz archive is below
