
# _archive_start_line=?; _script=?; are above.

tmpdir=$(mktemp -d)

trap "rm -rf $tmpdir" EXIT

self="$0"
basename_of_self="$(basename "$self")"

# I want to distinguish "me" and "./me" of $0.
# The difference between this method and `dirname` is:
# dirname converts "" to "./"
# but this method doesn't.
# For example if $0 == "me"
# `dirname $0` == "./"
# $dirname_of_self == ""
dirname_of_self="${self%$basename_of_self}"

if [ -n "$dirname_of_self" ];then
    # when this executable executed as a command in $PATH.

    # get full path of $0
    self="$(command -v "$0")"
fi


tail -n +$_archive_start_line < "$self" | gunzip | tar -x -C $tmpdir

$tmpdir/"$_script" "$@"
exit

# tar.gz archive is below
