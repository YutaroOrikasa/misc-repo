#!/bin/sh

# readparse()
# Equivalent to such a bash command:
#   read var1 var2 ... <<<"string to parse"
# But this can be run on pure posix shell.
# usage:
# readparse "string to parse" var1 var2 ...
# STR="string to parse" readparse var1 var2 ...
readparse() {                                          
    if [ -z "$STR" ];then
        STR=$1 eval 'shift; readparse "$@"'
    else
        # shift
        read "$@" <<-EOF
		$STR
	EOF
    fi
}

