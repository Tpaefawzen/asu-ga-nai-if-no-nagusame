#!/bin/sh

################################################################################
#
# 明日がないIFの慰め.sh - カウンセラープログラム
#
# Writer: Tpaefawzen <GitHub: Tpaefawzen>
# License: WTFPL
#
################################################################################

# boilerplate
set -eu
umask 0022
export LC_ALL=C
if _posix_path="$( command -p getconf PATH 2>/dev/null )"; then
	export PATH="${_posix_path}${PATH+:}${PATH-:}"
fi
export UNIX_STD=2003 # HP-UX
export POSIXLY_CORRECT=1 # GNU

# == utilities ==

# GLOBALIZATION?
_() {
	:
}

# error_exit STATUS MSG
error_exit() {
	printf "%s: %s\n" "${0##*/}" "$2" 1>&2
	exit $1
}

# usage [STATUS]
usage() {
	_stream=2
	case ${1:-} in 0) _stream=1;; esac
	cat <<-USAGE 1>&${_stream}
	Usage: ${0##*/}
	USAGE
	exit ${1:-1}
}

# == parameter ==
exit_status=0

# == Parse args ==
case "$# ${1:-}" in '1 --help'|'1 --usage'|'1 -h') usage 0;; esac

	case $# in 0)
		:
		;;
	*)
		usage
		;;
esac

# == OUTPUT AND INPUT MUST BE INTERACTIVE ==
if ( ! [ -t 0 ] ) || ( ! [ -t 1 ] ); then
	error_exit 1 "interactive use only"
fi

# == main ==
printf "明日があるかどうか: "
read -r response

case "$response" in ない|無い)
	echo "少し落ち込むかもしれませんが、新しいチャンスがいつか訪れるはずです。前向きに考えてみましょう。"
	;;
ある|有る)
	echo "よかったね"
	;;
*)
	echo "？・・・＃・・・？"
	exit_status=2
	;;
esac

# == finally ==
exit ${exit_status}
