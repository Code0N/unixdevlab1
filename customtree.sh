#!/bin/bash

dirName=$1
if [ -z "$dirName"]; then
	dirName="/home"
fi

read -p "Do you want to see hiden files? 1 / 2 > " hfqpar
thecommand="ls"

if [ $hfqpar -eq 1 ]; then
	thecommand="ls -a"
fi

custree(){
	local catalog=$1
	list=$($thecommand $catalog)

	for lvar in $list; do
		if [ $var!='.' ] && [ $var!='..' ]; then
			echo "$catalog/$lvar"
			lpath="$catalog/$lvar"
			if [ -d $lpath ]; then
				custree $lpath
			fi
		fi
	done
}

custree $dirName
exit 0