#!/usr/bin/env bash

#cmd_1=$1
#string_1=$2

case $1 in
	login) lpass login --trust $2 ;;
	show) echo "Make Sure No One's Peeking!" && sleep 3 && lpass show -x $2 ;;
	look) lpass show $2 ;;
	find) lpass ls -l | grep --color=auto $2 ;;
	search) lpass ls -l | grep --color=auto $2 ;;
	*) echo "currently only supporting login,show,look,find, and search (alias of find)" && exit 1 ;;
esac
